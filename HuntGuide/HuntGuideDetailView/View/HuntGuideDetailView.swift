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
    private let imageVerticalOffset: CGFloat = 32
    private let imageHorizontalInset: CGFloat = 32
    
    // Indicator
    private var steps: Int
    private var indicators: [UIView] = []
    private var progressLayers: [CAShapeLayer] = []
    private var currentIndicatorIndex = 0
    private var animationDuration: TimeInterval = 10

    // UI Elements
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .cyan
        return label
    }()

    private let topicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Now frames and bounds are guaranteed to be set
        NSLog("layoutSubviews")
        addIndicatorProgressLayers()
    }

    // Setup View
    private func setupView() {
        addSubview(closeButton)
        addSubview(subjectLabel)
        addSubview(topicLabel)
        addSubview(descriptionLabel)
        addSubview(weaponImageView)
        addProgressIndicator()
    }
    
    // Add progress indicator views with animated progress layers
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
    
    private func addIndicatorProgressLayers() {
        for (index, indicator) in indicators.enumerated() {
            // Add progress layer to each indicator
            let progressLayer = CAShapeLayer()
            progressLayer.strokeColor = UIColor.white.cgColor
            progressLayer.lineWidth = 4 // Set the height of the progress line
            progressLayer.lineCap = .round
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.strokeEnd = 0 // Start the stroke at zero

            // Save the layer for later animation
            indicator.layer.addSublayer(progressLayer)
            progressLayers.append(progressLayer)
        }
        
        // Set paths after layout is complete
        for (index, progressLayer) in progressLayers.enumerated() {
            guard index < indicators.count else { continue }
            let indicator = indicators[index]
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: indicator.frame.height / 2))
            path.addLine(to: CGPoint(x: indicator.frame.width, y: indicator.frame.height / 2))
            progressLayer.path = path.cgPath
        }
    }

    // Setup Constraints
    private func setupConstraints() {
        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(verticalPadding * 2)
            make.leading.equalToSuperview().offset(horizontalPadding)
        }

        topicLabel.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(verticalPadding)
            make.leading.equalTo(subjectLabel)
            make.width.lessThanOrEqualToSuperview().offset(-horizontalPadding * 2)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(topicLabel.snp.bottom).offset(verticalPadding)
            make.leading.equalTo(topicLabel)
            make.trailing.equalToSuperview().offset(-horizontalPadding)
        }

        weaponImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(imageVerticalOffset)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-imageHorizontalInset)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-verticalPadding)
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
        // Start animation for the current index indicator
        if currentIndex < progressLayers.count {
            resetIndicators()
            currentIndicatorIndex = currentIndex
            animateCurrentIndicator()
        }
    }
    
    // Animate the current indicator progress
    func animateCurrentIndicator() {
        NSLog("animateCurrentIndicator")
        guard currentIndicatorIndex < progressLayers.count else { return }
        let progressLayer = progressLayers[currentIndicatorIndex]
        
        NSLog("animateCurrentIndicator: \(progressLayer.frame)")

        // Define the progress animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        progressLayer.strokeEnd = 1
        progressLayer.add(animation, forKey: "progressAnimation")
    }

    // Pause animation
    func pauseAnimation() {
        NSLog("pauseAnimation")
        guard currentIndicatorIndex < progressLayers.count else { return }
        let layer = progressLayers[currentIndicatorIndex]
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    // Resume animation
    func resumeAnimation() {
        NSLog("resumeAnimation")
        guard currentIndicatorIndex < progressLayers.count else { return }
        let layer = progressLayers[currentIndicatorIndex]
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    // Reset all indicators
    func resetIndicators() {
        NSLog("resetIndicators")
        for progressLayer in progressLayers {
            progressLayer.removeAllAnimations()
            progressLayer.strokeEnd = 0
        }
    }
    
    // Advance to the next indicator
    func advanceToNextIndicator() {
        NSLog("advanceToNextIndicator")
        currentIndicatorIndex = (currentIndicatorIndex + 1) % steps
        animateCurrentIndicator()
    }

    // Expose closeButton for adding action in the view controller
    func addCloseButtonTarget(target: Any?, action: Selector) {
        closeButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
