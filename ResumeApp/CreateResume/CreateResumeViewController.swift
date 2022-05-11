//
//  CreateResumeViewController.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import UIKit

class CreateResumeViewController: BaseViewController, UIAdaptivePresentationControllerDelegate {
    
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
    
    // since that state is only UI oriented, I am not keeping in viewModel.
    var dragInfoLabelState : CreateResumeDragLabelState = .none {
        didSet {
            // prevent updating UI if the new value is the same with oldValue.
            if oldValue == dragInfoLabelState {
                return
            }
            switch dragInfoLabelState {
            case .none : dragInfoLabel.text = "" ; break;
            case .dragMore : dragInfoLabel.text = "Drag down to go to back" ; break;
            case .releaseToGoBack : dragInfoLabel.text = "Release to go to back" ; break;
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dragInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        viewModel.onUIReady()
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        if viewModel.hasUnsavedEdit {
            return false
        }
        return true
    }
    
    func showUnsavedAlertForDismiss() {
        let alert = UIAlertController(title: "Yuo have unsaved work", message: "Are you sure to exit? You have unsaved work.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save and Exit", style: .default, handler: { alert in
            
        }))
        alert.addAction(UIAlertAction(title: "Exit Without Saving", style: .destructive, handler: { alert in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { alert in
            
        }))
        present(alert, animated: true)
    }
    
    func userWantstoGoBack() {
        if viewModel.hasUnsavedEdit {
            showUnsavedAlertForDismiss()
            return
        }
        dismiss(animated: true)
    }
    
}


extension CreateResumeViewController : BaseViewModelDeletegate {
    func updateUI() {
        
    }
}

extension CreateResumeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offset =  scrollView.contentOffset;
            if offset.y < -50 {
                dragInfoLabelState = .releaseToGoBack
            } else if offset.y > -50 && offset.y < -5  {
                dragInfoLabelState = .dragMore
            } else {
                dragInfoLabelState = .none
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.scrollView {
            if dragInfoLabelState == .releaseToGoBack {
                userWantstoGoBack()
            }
        }
    }
}
