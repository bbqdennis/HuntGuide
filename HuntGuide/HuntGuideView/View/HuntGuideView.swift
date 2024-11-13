//
//  HuntGuideView.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit
import SnapKit

class HuntGuideView: UIView {
    
    // Layout Constants
    private let containerViewBottomOffset: CGFloat = -100
    private let containerViewHeight: CGFloat = 56
    private let containerViewWidth: CGFloat = 248
    private let containerViewCornerRadius: CGFloat = 28
    private let containerViewBorderWidth: CGFloat = 2
    
    private let infoIconLeadingPadding: CGFloat = 16
    private let infoIconSize: CGFloat = 24
    
    private let titleLabelLeadingOffset: CGFloat = 8
    private let titleLabelTopOffset: CGFloat = 10
    
    private let subtitleLabelLeadingOffset: CGFloat = 8
    private let subtitleLabelTopOffset: CGFloat = 2

    // Setup View
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.cornerRadius = 28
        return view
    }()
    
    private let infoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HUNT GUIDE"
        label.font = UIFont.boldSystemFont(ofSize: 14)  // Set to bold font
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tips and tricks to get you started"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.white
        return label
    }()
    
    private let buttonAction: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var buttonCallback: (() -> Void)?
    
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
    
    // Setup Init
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(infoIcon)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(buttonAction)
        
        // Update view properties using constants
        containerView.layer.cornerRadius = containerViewCornerRadius
        containerView.layer.borderWidth = containerViewBorderWidth
    }
    
    // Setup Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(containerViewBottomOffset)
            make.height.equalTo(containerViewHeight)
            make.width.equalTo(containerViewWidth)
        }
        
        infoIcon.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(infoIconLeadingPadding)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(infoIconSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoIcon.snp.trailing).offset(titleLabelLeadingOffset)
            make.top.equalTo(containerView).offset(titleLabelTopOffset)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoIcon.snp.trailing).offset(subtitleLabelLeadingOffset)
            make.top.equalTo(titleLabel.snp.bottom).offset(subtitleLabelTopOffset)
        }
        
        buttonAction.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
    
    // Function Call
    // Expose button for adding action in the view controller
    func addButtonTarget(target: Any?, action: Selector) {
        buttonAction.addTarget(target, action: action, for: .touchUpInside)
    }
}
