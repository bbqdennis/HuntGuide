//
//  HuntGuideViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideViewController: UIViewController {

    // Init
    private let huntGuideView = HuntGuideView() // Initialize the custom view

    // View Cycle
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
    
    // Navigation
    private func pushToHuntGuideDetailViewController() {
        NSLog("pushToHuntGuideDetailViewController")
        let huntGuideDetailVC = HuntGuideDetailViewController()
        navigationController?.pushViewController(huntGuideDetailVC, animated: true)
    }
    
    // Action
    private func handleButtonTap() {
        // Handle button tap action
        print("Hunt Guide button tapped")
        pushToHuntGuideDetailViewController()
    }
}
