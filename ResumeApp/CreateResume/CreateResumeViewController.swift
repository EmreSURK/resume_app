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
    @IBOutlet weak var projectDetailsTextField: UITextField!
    
    @IBOutlet weak var workSummaryContainerStack: UIStackView!
    @IBOutlet weak var skillsContainerStack: UIStackView!
    @IBOutlet weak var educationContainerStack: UIStackView!
    
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
        projectDetailsTextField.delegate = self
                
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        if viewModel.hasUnsavedEdit {
            return false
        }
        return true
    }
   
    @IBAction func btnEducationWorkSummaryTapped(_ sender: UIButton) {
        AddEducationViewController.present(sender: self, delegate: self)
    }
    
    @IBAction func btnAddWorkSummaryTapped(_ sender: UIButton) {
        AddWorkSummaryViewController.present(sender: self, delegate: self)
    }
    
    @IBAction func btnAddSkillTapped(_ sender: UIButton) {
        AddSkillViewController.present(sender: self, delegate: self)
    }
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        viewModel.saveData()
        showsimpleAlert(title: "Saved", message: "Your resume is saved.")
    }
}


extension CreateResumeViewController : BaseViewModelDeletegate {
    func updateUI() {
        
        // show loading indicator until the data is ready.
        scrollView.isHidden = !viewModel.isInitialDataReady
        activityIndicator.isHidden = viewModel.isInitialDataReady
        btnSave.isHidden = !viewModel.hasUnsavedEdit
        
        mobileNumberTextField.text = viewModel.resume.mobileNumber
        
        updateWorkSummary()
        updateSkills()
        updateEducation()
    }
    
    func updateWorkSummary() {
        workSummaryContainerStack.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        viewModel.resume.workSummary.forEach { summary in
            let nameLabel = listItemLabel(text:summary.companyName)
            
            let durationLabel = listItemLabel(text:summary.duration)
            durationLabel.setContentHuggingPriority(.init(rawValue: 252), for: .horizontal)
            
            let stack = UIStackView(arrangedSubviews: [ nameLabel, durationLabel ])
            stack.axis = .horizontal
            workSummaryContainerStack.addArrangedSubview(stack)
        }
    }
    
    func updateSkills() {
        skillsContainerStack.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        viewModel.resume.skills.forEach { skill in
            skillsContainerStack.addArrangedSubview(listItemLabel(text:skill))
        }
    }
    
    func updateEducation() {
        educationContainerStack.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        viewModel.resume.educationDetails.forEach { education in
            let classNameLabel = listItemLabel(text: education.className)
            let passingYearLabel = listItemLabel(text: education.passingYear)
            let cgpaLabel = listItemLabel(text: education.percentageCGPA)
            let stack = UIStackView(arrangedSubviews: [classNameLabel,passingYearLabel,cgpaLabel])
            stack.axis = .horizontal
            
            educationContainerStack.addArrangedSubview(stack)
        }
    }
    
    func listItemLabel(text : String? = "") -> UILabel {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.text = text
        return nameLabel
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
//        case workSummaryTextField: viewModel.resume.workSummary = textField.text;
            //        case projectDetailsTextField: viewModel.resume.projectDetails = textField.text; break;
        default: break
            
        }
        viewModel.userUpdatedData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mobileNumberTextField {
            emailAdressTextField.becomeFirstResponder()
        } else if textField == emailAdressTextField {
            residanceAddressTextField.becomeFirstResponder()
        } else if textField == residanceAddressTextField {
            careerObjectiveTextField.becomeFirstResponder()
        } else if textField == careerObjectiveTextField {
            totalYearOfExperienceTextField.becomeFirstResponder()
        } else if textField == totalYearOfExperienceTextField {
            textField.endEditing(true)
        }
        
        return true
    }
    
}


extension CreateResumeViewController : UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension CreateResumeViewController : AddWorkSummaryDelegate {
    func summaryAdded(summary: WorkSummaryModal) {
        viewModel.resume.workSummary.append(summary)
        viewModel.userUpdatedData()
    }
}

extension CreateResumeViewController : AddSkillDelegate {
    func skillAdded(skill: String) {
        viewModel.resume.skills.append(skill)
        viewModel.userUpdatedData()
    }
}

extension CreateResumeViewController : AddEducationDelegate {
    func educationAdded(education: EducationDetailsModal) {
        viewModel.resume.educationDetails.append(education)
        viewModel.userUpdatedData()
    }
}
