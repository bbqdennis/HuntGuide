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
        huntGuideView.addButtonTarget(target: self, action: #selector(handleButtonTap))
    }
    
    // Navigation
    private func presentHuntGuideDetailViewController() {
        NSLog("presentHuntGuideDetailViewController")
        let huntGuideDetailVC = HuntGuideDetailViewController()
        huntGuideDetailVC.modalPresentationStyle = .fullScreen // Optional: Present full screen
        present(huntGuideDetailVC, animated: true, completion: nil)
    }
    
    // Action
    @objc private func handleButtonTap() {
        // Handle button tap action
        print("Hunt Guide button tapped")
        presentHuntGuideDetailViewController()
    }
}
