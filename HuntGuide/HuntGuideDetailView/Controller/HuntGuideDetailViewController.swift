//
//  HuntGuideDetailViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideDetailViewController: UIViewController {

    private let huntGuideDetailView = HuntGuideDetailView()

    override func loadView() {
        self.view = huntGuideDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sample data for demonstration
        let huntGuideModel = HuntGuideDetailModel(
            stepNumber: "01",
            title: "MASTER YOUR LOADOUT",
            subtitle: "CHOOSE THE PERFECT WEAPON COMBO",
            description: "In your inventory you will be able to select your loadout by picking the two weapons you’ll rely on during the hunt. Each gun has unique strengths, so choose a combo that best matches your play style for maximum impact.",
            imageName: "weapon_image" // Add your image to the assets named "weapon_image"
        )
        
        huntGuideDetailView.configure(with: huntGuideModel)
    }
}
