//
//  UIKitExtensions.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
import UIKit
extension UIViewController {
    

    public func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UITableViewCell {
    @objc static var defaultIdentifier: String {
        return String(describing: self)
    }
}


extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType cellClass: T.Type) {
            let identifier = String(describing: cellClass)
            
            // if the XIB file exists
            let nib = UINib(nibName: identifier, bundle: nil)
            if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
                register(nib, forCellReuseIdentifier: identifier)
            } else {
                // If no XIB exists the register the class itself
                register(cellClass, forCellReuseIdentifier: identifier)
            }
        }
    
 
    func dequeueReusableCell<T: UITableViewCell>(ofType cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.defaultIdentifier, for: indexPath) as? T
    }
}


extension UIImageView {
    //set image
    func setImage(with urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
        //load from cache
        ImageCache.loadImage(from: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
