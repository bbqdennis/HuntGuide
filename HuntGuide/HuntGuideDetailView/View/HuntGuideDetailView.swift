//
//  HuntGuideDetailView.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit
import SnapKit

class HuntGuideDetailView: UIView {

    // UI Elements
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .cyan
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .cyan
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
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
    override init(frame: CGRect) {
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
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(descriptionLabel)
        addSubview(weaponImageView)
    }

    // Setup Constraints
    private func setupConstraints() {
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(8)
            make.leading.equalTo(stepLabel)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(subtitleLabel)
            make.trailing.equalToSuperview().offset(-16)
        }

        weaponImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.lessThanOrEqualToSuperview().offset(-32)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-16)
        }
    }

    // Configure View
    func configure(with model: HuntGuideDetailModel) {
        stepLabel.text = model.stepNumber + "  " + model.title
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        descriptionLabel.text = model.description
        weaponImageView.image = UIImage(named: model.imageName)
    }
}
