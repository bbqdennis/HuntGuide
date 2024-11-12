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
        addSubview(subjectLabel)
        addSubview(topicLabel)
        addSubview(descriptionLabel)
        addSubview(weaponImageView)
    }

    // Setup Constraints
    private func setupConstraints() {
        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        topicLabel.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(16)
            make.leading.equalTo(subjectLabel)
            make.width.lessThanOrEqualToSuperview().offset(-32)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(topicLabel.snp.bottom).offset(16)
            make.leading.equalTo(topicLabel)
            make.trailing.equalToSuperview().offset(-16)
        }

        weaponImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-32)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-16)
        }
    }

    // Configure View
    func configure(with model: HuntGuideDetailModel) {
        subjectLabel.text = model.subject
        topicLabel.text = model.topic
        descriptionLabel.text = model.description
        weaponImageView.image = UIImage(named: model.image)
    }
}
