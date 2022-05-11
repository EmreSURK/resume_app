//
//  CreateResumeViewController.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import UIKit

class CreateResumeViewController: BaseViewController {
    
    // we can also use diffent navigation styles. I leave that code as an eaxmple.
    /*static func push(sender : UIViewController) {
     let vc = CreateResumeViewController(nibName: CreateResumeViewController.className, bundle: nil)
     // I use ! to wrap navigation controller of the sender. If it crash, that will notify the developer. It is not possible that owking in dev but crashing in prod, so that is safe.
     vc.viewModel = CreateResumeViewModel(vc)
     sender.navigationController!.pushViewController(vc, animated: true)
     }*/
    
    static func present(sender : UIViewController, animated : Bool, resume : ResumeModal? = nil ) {
        let vc = CreateResumeViewController(nibName: CreateResumeViewController.className, bundle: nil)
        vc.viewModel = ResumeViewModel(vc)
        vc.viewModel.resume = resume
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: animated)
    }
    
    var viewModel : ResumeViewModel! = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var residanceAddressTextField: UITextField!
    @IBOutlet weak var careerObjectiveTextField: UITextField!
    @IBOutlet weak var totalYearOfExperienceTextField: UITextField!
    @IBOutlet weak var workSummaryTextField: UITextField!
    @IBOutlet weak var projectDetailsTextField: UITextField!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        viewModel.onUIReady()
        
        // make initial update.
        updateUI()
    }
    
    func initUI() {
        navigationBar.delegate = self
        mobileNumberTextField.delegate = self
        emailAdressTextField.delegate = self
        residanceAddressTextField.delegate = self
        careerObjectiveTextField.delegate = self
        totalYearOfExperienceTextField.delegate = self
        workSummaryTextField.delegate = self
        projectDetailsTextField.delegate = self
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        if viewModel.hasUnsavedEdit {
            return false
        }
        return true
    }
    
    func showSavedAlert() {
        let alert = UIAlertController(title: "Saved", message: "Your resume is saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        viewModel.saveData()
        showSavedAlert()
    }
}


extension CreateResumeViewController : BaseViewModelDeletegate {
    func updateUI() {
        
        // show loading indicator until the data is ready.
        scrollView.isHidden = !viewModel.isInitialDataReady
        activityIndicator.isHidden = viewModel.isInitialDataReady
        btnSave.isHidden = !viewModel.hasUnsavedEdit
        
        mobileNumberTextField.text = viewModel.resume.mobileNumber
    }
}


extension CreateResumeViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case mobileNumberTextField: viewModel.resume.mobileNumber = textField.text; break;
        case emailAdressTextField: viewModel.resume.emailAdress = textField.text; break;
        case residanceAddressTextField: viewModel.resume.residenceAddress = textField.text; break;
        case careerObjectiveTextField: viewModel.resume.careerObjective = textField.text; break;
            //        caawdse totalYearOfExperienceTextField: viewModel.resume.totalYearsOfExperience = textField.text; break;
        case workSummaryTextField: viewModel.resume.workSummary = textField.text;
            //        case projectDetailsTextField: viewModel.resume.projectDetails = textField.text; break;
        default: break
            
        }
        viewModel.userUpdatedData()
        return true
    }
}


extension CreateResumeViewController : UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
