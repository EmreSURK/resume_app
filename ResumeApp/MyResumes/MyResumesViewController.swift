//
//  ViewController.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import UIKit

class MyResumesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
   

}

// MARK: UI Buttons
extension MyResumesViewController {
    @IBAction func btnCreateNewResumeTapped(_ sender: UIButton) {
        CreateResumeViewController.present(sender: self)
    }
}

