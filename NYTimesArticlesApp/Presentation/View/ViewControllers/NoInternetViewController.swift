//
//  NoInternetViewController.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import UIKit

class NoInternetViewController: UIViewController {
    
    var retryAction: (() -> Void)?
    
    @IBOutlet weak var retryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Set up your UI elements, like labels or buttons
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }
    
    @objc private func retryTapped() {
        retryAction?()
    }
}
