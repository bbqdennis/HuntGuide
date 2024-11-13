//
//  HuntGuideDetailViewController.swift
//  HuntGuide
//
//  Created by Dennis Cheng on 12/11/2024.
//

import UIKit

class HuntGuideDetailViewController: UIViewController {

    private var models: [HuntGuideDetailModel] = []
    private var huntGuideDetailView: HuntGuideDetailView!
    private var currentIndex = 0
    private var autoAdvanceTimer: Timer?
    private let autoAdvanceInterval: TimeInterval = 10
    
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
        huntGuideDetailView.addCloseButtonTarget(target: self, action: #selector(handleCloseButtonTap))
        self.view = huntGuideDetailView
    }
    
    private func setupGesture() {
        // Add single tap gesture recognizer for advancing to the next item
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        huntGuideDetailView.addGestureRecognizer(tapGesture)
        
        // Add long press gesture recognizer for tap to hold (pause the timer)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        huntGuideDetailView.addGestureRecognizer(longPressGesture)
        
        // Add swipe gesture recognizers for left and right swipe
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        huntGuideDetailView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = .right
        huntGuideDetailView.addGestureRecognizer(swipeRightGesture)
    }

    // Setup Auto-Advance Timer
    private func startAutoAdvanceTimer() {
        autoAdvanceTimer = Timer.scheduledTimer(timeInterval: autoAdvanceInterval, target: self, selector: #selector(autoAdvance), userInfo: nil, repeats: true)
        huntGuideDetailView.resumeAnimation()
    }

    private func stopAutoAdvanceTimer() {
        autoAdvanceTimer?.invalidate()
        autoAdvanceTimer = nil
        huntGuideDetailView.pauseAnimation() // Pause animation for current indicator
    }
    
    // Advance to the next item automatically
    @objc private func autoAdvance() {
        NSLog("Auto-advancing to the next item")
        currentIndex = (currentIndex + 1) % models.count
        loadCurrentModel()
    }
    
    // Load current model into the view and animate indicator
    private func loadCurrentModel() {
        if currentIndex < models.count {
            let model = models[currentIndex]
            huntGuideDetailView.configure(with: model)
            huntGuideDetailView.updateIndicator(currentIndex: currentIndex)
        }
    }

    // Actions
    @objc private func handleCloseButtonTap() {
        NSLog("Close button tapped, dismissing view controller")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTap() {
        NSLog("Single tap detected, moving to next item")
        stopAutoAdvanceTimer()
        
        // Move to the next item
        currentIndex = (currentIndex + 1) % models.count
        loadCurrentModel()
        
        // Restart the timer
        startAutoAdvanceTimer()
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            NSLog("Long press began, pausing auto-advance timer")
            stopAutoAdvanceTimer() // Pause both the timer and animation
        } else if gesture.state == .ended || gesture.state == .cancelled {
            NSLog("Long press ended, resuming auto-advance timer")
            startAutoAdvanceTimer() // Resume both the timer and animation
        }
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        stopAutoAdvanceTimer() // Stop the timer and animation for a manual swipe
        
        if gesture.direction == .left {
            NSLog("Swipe left detected, moving to next item")
            currentIndex = (currentIndex + 1) % models.count
        } else if gesture.direction == .right {
            NSLog("Swipe right detected, moving to previous item")
            currentIndex = (currentIndex - 1 + models.count) % models.count
        }
        
        loadCurrentModel()
        startAutoAdvanceTimer() // Restart the timer and animation after the swipe
    }
    
    // View Cycle
    override func loadView() {
        // Do nothing here because `huntGuideDetailView` will be set after `setupModel`
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupView()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // for make sure the huntGuideDetailView frame is okay
        loadCurrentModel()
        startAutoAdvanceTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("View is disappearing, stopping auto-advance timer")
        stopAutoAdvanceTimer()
    }
}
