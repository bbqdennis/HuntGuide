//
//  HuntGuideViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideViewController: UIViewController {

    private let huntGuideView = HuntGuideView() // Initialize the custom view

    override func loadView() {
        self.view = huntGuideView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup if needed
        huntGuideView.configureButtonAction { [weak self] in
            self?.handleButtonTap()
        }
    }

    private func handleButtonTap() {
        // Handle button tap action
        print("Hunt Guide button tapped")
    }
}
