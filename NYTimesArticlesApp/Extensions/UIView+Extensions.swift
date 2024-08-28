//
//  UIView+Extensions.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    private var containerForOverlay: UIView {
        return navigationController?.view ?? view
    }
    
    // Display the loading indicator
    func displayLoadingIndicator() {
        containerForOverlay.showLoadingSpinner()
    }
    
    // Hide the loading indicator
    func hideLoadingIndicator() {
        containerForOverlay.removeLoadingSpinner()
    }
}

extension UIView {
    
    // Show the loading spinner
    func showLoadingSpinner() {
        configureLoadingSpinner()
    }
    
    // Remove the loading spinner
    func removeLoadingSpinner() {
        clearLoadingSpinner()
    }
    
    private var spinner: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tag = Constant.spinnerTag
        return spinner
    }
    
    private var overlay: UIView {
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = .clear
        overlay.tag = Constant.loadingOverlayTag
        return overlay
    }
    
    private func configureLoadingSpinner() {
        guard !isLoadingSpinnerVisible() else { return }
        
        let overlayView = overlay
        let spinnerView = spinner
        
        // Add spinner to overlay
        overlayView.addSubview(spinnerView)
        addSubview(overlayView)
        
        // Set overlay constraints
        NSLayoutConstraint.activate([
            overlayView.heightAnchor.constraint(equalTo: heightAnchor),
            overlayView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        // Set spinner constraints
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])
        
        spinnerView.startAnimating()
    }
    
    private func clearLoadingSpinner() {
        guard let overlayView = viewWithTag(Constant.loadingOverlayTag),
              let spinnerView = viewWithTag(Constant.spinnerTag) as? UIActivityIndicatorView else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            overlayView.alpha = 0.0
            spinnerView.stopAnimating()
        }) { _ in
            spinnerView.removeFromSuperview()
            overlayView.removeFromSuperview()
        }
    }
    
    private func isLoadingSpinnerVisible() -> Bool {
        return viewWithTag(Constant.loadingOverlayTag) != nil && viewWithTag(Constant.spinnerTag) != nil
    }
}
