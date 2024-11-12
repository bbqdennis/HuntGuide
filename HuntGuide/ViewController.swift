//
//  ViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class ViewController: UIViewController {
    
    func pushToHuntGuideViewController() {
        NSLog("pushToHuntGuideViewController")
        let huntGuideVC = HuntGuideViewController()
        let aNavigationController = UINavigationController(rootViewController: huntGuideVC)
        
        let window = UIApplication.shared.windows.first!
        window.rootViewController = aNavigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Automatically push to HuntGuideViewController on load
        pushToHuntGuideViewController()
    }
}
