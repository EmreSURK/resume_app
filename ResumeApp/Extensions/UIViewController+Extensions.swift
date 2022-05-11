//
//  UIViewController+Extensions.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showsimpleAlert( title : String, message : String ) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func enableDismissOnTap() {
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
