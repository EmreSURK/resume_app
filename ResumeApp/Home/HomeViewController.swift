//
//  ViewController.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import UIKit

class HomeViewController: UIViewController {

    static func present(sender : UIViewController ) {
        let storyboard = UIStoryboard(name: HomeViewController.className, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:  HomeViewController.className)
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true)
    }
    
}

// MARK: UI Buttons
extension HomeViewController {
    @IBAction func btnCreateNewResumeTapped(_ sender: UIButton) {
        CreateResumeViewController.present(sender: self,animated: true)
    }
}

