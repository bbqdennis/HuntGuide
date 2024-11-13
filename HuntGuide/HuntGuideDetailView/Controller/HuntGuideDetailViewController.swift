//
//  HuntGuideDetailViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideDetailViewController: UIViewController {

    private var models: [HuntGuideDetailModel] = []
    private var huntGuideDetailView: HuntGuideDetailView! // Delay to load since we need the model count for setup the indicator in HuntGuideDetailView
    private var currentIndex = 0
    
    // Setup Init
    private func setupModel() {
        if let loadedModels = HuntGuideDetailModel.loadFromBundle() {
            models = loadedModels
        } else {
            print("Failed to load models from JSON.")
        }
    }
    
    private func setupView() {
        // Initialize huntGuideDetailView after loading models
        huntGuideDetailView = HuntGuideDetailView(steps: models.count)
        // Additional setup if needed
        huntGuideDetailView.addCloseButtonTarget(target: self, action: #selector(handleCloseButtonTap))
        self.view = huntGuideDetailView // set self.view
    }
    
    private func setupGesture() {
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        huntGuideDetailView.addGestureRecognizer(tapGesture)
        
        // Add swipe gesture recognizers for left and right swipe
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        huntGuideDetailView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = .right
        huntGuideDetailView.addGestureRecognizer(swipeRightGesture)
    }

    // Common
    private func loadCurrentModel() {
        if currentIndex < models.count {
            let model = models[currentIndex]
            huntGuideDetailView.configure(with: model)
            huntGuideDetailView.updateIndicator(currentIndex: currentIndex)
        }
    }

    // Actions
    @objc private func handleCloseButtonTap() {
        // Handle close action, for example, dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTap() {
        // Increment the index to load the next model
        currentIndex = (currentIndex + 1) % models.count
        loadCurrentModel()
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            // Swipe left to go to the next model
            currentIndex = (currentIndex + 1) % models.count
        } else if gesture.direction == .right {
            // Swipe right to go to the previous model
            currentIndex = (currentIndex - 1 + models.count) % models.count
        }
        loadCurrentModel()
    }
    
    // View Cycle
    override func loadView() {
        // Do nothing here because `huntGuideDetailView` will be set after `setupModel`
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel() // load the model
        setupView()
        setupGesture()
        loadCurrentModel()
    }
}
