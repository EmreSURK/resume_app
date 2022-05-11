//
//  SplashViewController.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import UIKit

class SplashViewController: UIViewController {

    
    // viewDidLoad is not ready to push another screen, we should wait until this VC being appeared.
    override func viewDidAppear(_ animated: Bool) {
        checkIfResumeAlreadyCreated()
    }
    
    func presentHomeScreen() {
        HomeViewController.present(sender: self)
    }
    
    func presentResumeScreen() {
        CreateResumeViewController.present(sender: self,animated: false)
    }
    
    func checkIfResumeAlreadyCreated() {
        DiskDataProvider.getResume { [weak self] resume in
            guard let self = self else {
                return
            }
            if resume == nil {
                self.presentHomeScreen()
            } else {
                self.presentResumeScreen()
            }
        }
    }
}
