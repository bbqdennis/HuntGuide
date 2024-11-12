//
//  HuntGuideView.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit
import SnapKit

class HuntGuideView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let infoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = .cyan
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HUNT GUIDE"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tips and tricks to get you started"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        return label
    }()
    
    private let buttonAction: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var buttonCallback: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(infoIcon)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(buttonAction)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            make.height.equalTo(80)
            make.width.equalTo(320)
        }
        
        infoIcon.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(16)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoIcon.snp.trailing).offset(16)
            make.top.equalTo(containerView).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoIcon.snp.trailing).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        buttonAction.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
    
    func configureButtonAction(callback: @escaping () -> Void) {
        buttonCallback = callback
    }
    
    @objc private func buttonTapped() {
        buttonCallback?()
    }
}
