//
//  BaseViewController.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-13.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }
    
    private let loadingBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.isHidden = true
        return view
    }()
    
    private func setupActivityIndicator() {
        loadingBackground.frame = self.view.bounds
        loadingBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(loadingBackground)
        
        activityIndicator.center = loadingBackground.center
        loadingBackground.addSubview(activityIndicator)
    }
    
    func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.loadingBackground.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.loadingBackground.isHidden = true
            }
        }
    }
    
    func showError(_ error: Error?) {
        guard let error = error else { return }
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
