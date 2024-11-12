//
//  HuntGuideDetailViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideDetailViewController: UIViewController {

    private let huntGuideDetailView = HuntGuideDetailView()
    private var models: [HuntGuideDetailModel] = []
    private var currentIndex = 0

    override func loadView() {
        self.view = huntGuideDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedModels = HuntGuideDetailModel.loadFromBundle() {
            models = loadedModels
            loadCurrentModel()
        } else {
            print("Failed to load models from JSON.")
        }
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        huntGuideDetailView.addGestureRecognizer(tapGesture)
    }

    private func loadCurrentModel() {
        if currentIndex < models.count {
            let model = models[currentIndex]
            huntGuideDetailView.configure(with: model)
        }
    }

    // Action
    @objc private func handleTap() {
        // Increment the index to load the next model
        currentIndex = (currentIndex + 1) % models.count
        loadCurrentModel()
    }
}
