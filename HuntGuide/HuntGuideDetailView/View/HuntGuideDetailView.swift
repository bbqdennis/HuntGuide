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
    private let verticalPadding: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let imageVerticalOffset: CGFloat = 32
    private let imageHorizontalInset: CGFloat = 32
    
    // Indicator
    private var steps: Int
    private var indicators: [UIView] = []

    // UI Elements
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

    // Setup View
    private func setupView() {
        addProgressIndicator()
        addSubview(subjectLabel)
        addSubview(topicLabel)
        addSubview(descriptionLabel)
        addSubview(weaponImageView)
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

        indicatorContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(verticalPadding)
            make.leading.equalToSuperview().offset(horizontalPadding)
            make.trailing.equalToSuperview().offset(-horizontalPadding)
            make.height.equalTo(4)
        }
    }

    // Setup Constraints
    private func setupConstraints() {
        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(verticalPadding * 2)
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
            indicator.backgroundColor = index <= currentIndex ? .white : .darkGray
        }
    }
}
