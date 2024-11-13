//
//  HuntGuideDetailView.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit
import SnapKit

class HuntGuideDetailView: UIView {

    // Define padding constants
    private let closeButtonTopPadding: CGFloat = -6
    private let verticalPadding: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let imageVerticalOffset: CGFloat = 16
    private let imageHorizontalInset: CGFloat = 32
    
    // Indicator
    private var steps: Int
    private var indicators: [UIView] = []
    private var progressLayer: CAShapeLayer? // Only one progress layer needed
    private var currentIndicatorIndex = 0
    private var animationDuration: TimeInterval = 10

    // UI Elements
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    // ScrollView and Content Container
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = PlanetXFont.titleFont()
        label.textColor = .cyan
        return label
    }()

    private let topicLabel: UILabel = {
        let label = UILabel()
        label.font = PlanetXFont.titleFont(size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = PlanetXFont.descriptionFont(size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let weaponImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // Init
    init(frame: CGRect = .zero, steps: Int) {
        self.steps = steps
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup View
    private func setupView() {
        addSubview(closeButton)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(subjectLabel)
        contentView.addSubview(topicLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(weaponImageView)
        
        addProgressIndicator()
    }
    
    // Add progress indicator views
    private func addProgressIndicator() {
        let indicatorContainer = UIStackView()
        indicatorContainer.axis = .horizontal
        indicatorContainer.alignment = .fill
        indicatorContainer.distribution = .fillEqually
        indicatorContainer.spacing = 4
        addSubview(indicatorContainer)

        for _ in 0..<steps {
            let indicator = UIView()
            indicator.backgroundColor = .darkGray
            indicator.layer.cornerRadius = 2
            indicators.append(indicator)
            indicatorContainer.addArrangedSubview(indicator)
        }

        // Constraints for close button
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(closeButtonTopPadding)
            make.leading.equalToSuperview().offset(0)
            make.width.height.equalTo(50)
        }

        // Constraints for indicator container
        indicatorContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(verticalPadding)
            make.leading.equalTo(closeButton.snp.trailing).offset(0)
            make.trailing.equalToSuperview().offset(-horizontalPadding)
            make.height.equalTo(4)
        }
    }
    
    private func addIndicatorProgressLayer(for index: Int) {
        progressLayer?.removeFromSuperlayer()
        progressLayer = nil

        let progressLayer = CAShapeLayer()
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = 4
        progressLayer.lineCap = .round
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0

        let indicator = indicators[index]
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: indicator.frame.height / 2))
        path.addLine(to: CGPoint(x: indicator.frame.width, y: indicator.frame.height / 2))
        progressLayer.path = path.cgPath

        indicator.layer.addSublayer(progressLayer)
        self.progressLayer = progressLayer
    }

    // Setup Constraints
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(0)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView.snp.height) // set to the at least scrollView height
        }

        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(verticalPadding)
            make.leading.equalTo(contentView).offset(horizontalPadding)
        }

        topicLabel.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(verticalPadding)
            make.leading.equalTo(subjectLabel)
            make.trailing.equalTo(contentView).offset(-horizontalPadding)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(topicLabel.snp.bottom).offset(verticalPadding)
            make.leading.equalTo(topicLabel)
            make.trailing.equalTo(contentView).offset(-horizontalPadding)
        }

        weaponImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(imageVerticalOffset)
            make.centerX.equalTo(contentView)
            make.width.lessThanOrEqualTo(contentView).offset(-imageHorizontalInset)
            make.bottom.equalTo(contentView).offset(-verticalPadding)
        }
    }

    // Configure View
    func configure(with model: HuntGuideDetailModel) {
        subjectLabel.text = model.subject
        topicLabel.text = model.topic
        descriptionLabel.text = model.description
        weaponImageView.image = UIImage(named: model.image)
    }

    // Update the progress indicator based on the current index
    func updateIndicator(currentIndex: Int) {
        for (index, indicator) in indicators.enumerated() {
            indicator.backgroundColor = index < currentIndex ? .white : .darkGray
        }
        if currentIndex < indicators.count {
            resetIndicators()
            currentIndicatorIndex = currentIndex
            animateCurrentIndicator()
        }
    }
    
    func animateCurrentIndicator() {
        addIndicatorProgressLayer(for: currentIndicatorIndex)
        
        guard let progressLayer = progressLayer else { return }

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        progressLayer.strokeEnd = 1
        progressLayer.add(animation, forKey: "progressAnimation")
    }

    func pauseAnimation() {
        guard let layer = progressLayer else { return }
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    func resumeAnimation() {
        guard let layer = progressLayer else { return }
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    func resetIndicators() {
        progressLayer?.removeAllAnimations()
        progressLayer?.removeFromSuperlayer()
        progressLayer = nil
    }

    func advanceToNextIndicator() {
        currentIndicatorIndex = (currentIndicatorIndex + 1) % steps
        animateCurrentIndicator()
    }

    func addCloseButtonTarget(target: Any?, action: Selector) {
        closeButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
