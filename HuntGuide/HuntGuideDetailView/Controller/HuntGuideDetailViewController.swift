//
//  HuntGuideDetailViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideDetailViewController: UIViewController {

    private var models: [HuntGuideDetailModel] = []
    private var huntGuideDetailView: HuntGuideDetailView! // Lazy initialization
    private var currentIndex = 0
    
    // Setup Init
    private func setupModel() {
        if let loadedModels = HuntGuideDetailModel.loadFromBundle() {
            models = loadedModels
            
            // Initialize huntGuideDetailView after loading models
            huntGuideDetailView = HuntGuideDetailView(steps: models.count)
            self.view = huntGuideDetailView // Set view
            
            loadCurrentModel()
            setupGesture() // Initialize gestures
        } else {
            print("Failed to load models from JSON.")
        }
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

    // Load the current model into the view
    private func loadCurrentModel() {
        if currentIndex < models.count {
            let model = models[currentIndex]
            huntGuideDetailView.configure(with: model)
            huntGuideDetailView.updateIndicator(currentIndex: currentIndex)
        }
    }

    // Actions
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
        // Do nothing here because `huntGuideDetailView` will be set in `setupModel`
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel() // Load models and initialize the view
    }
}
