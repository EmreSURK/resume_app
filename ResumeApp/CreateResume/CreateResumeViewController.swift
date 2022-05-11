//
//  CreateResumeViewController.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import UIKit

class CreateResumeViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    // we can also use diffent navigation styles. I leave that code as an eaxmple.
    /*static func push(sender : UIViewController) {
        let vc = CreateResumeViewController(nibName: CreateResumeViewController.className, bundle: nil)
        // I use ! to wrap navigation controller of the sender. If it crash, that will notify the developer. It is not possible that owking in dev but crashing in prod, so that is safe.
        vc.viewModel = CreateResumeViewModel(vc)
        sender.navigationController!.pushViewController(vc, animated: true)
    }*/
    
    static func present(sender : UIViewController) {
        let vc = CreateResumeViewController(nibName: CreateResumeViewController.className, bundle: nil)
        vc.viewModel = CreateResumeViewModel(vc)
        vc.isModalInPresentation = false
        vc.presentationController?.delegate = vc
        sender.present(vc, animated: true)
    }
    
    var viewModel : CreateResumeViewModel! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUIReady()
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        if viewModel.hasUnsavedEdit {
            return false
        }
        return true
    }
    
}


extension CreateResumeViewController : BaseViewModelDeletegate {
    func updateUI() {
        
    }
}
