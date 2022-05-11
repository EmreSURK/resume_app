//
//  AddWorkSummaryViewController.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import UIKit

class AddEducationViewController: BaseViewController {

    static func present( sender : UIViewController, delegate : AddEducationDelegate ) {
        let vc = AddEducationViewController(nibName: AddEducationViewController.className, bundle: nil)
        vc.delegate = delegate
        sender.present(vc, animated: true)
    }
    
    @IBOutlet weak var classSegment: UISegmentedControl!
    @IBOutlet weak var passingYearTextField: UITextField!
    @IBOutlet weak var cgpaTextfield: UITextField!
    
    var delegate : AddEducationDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        passingYearTextField.delegate = self
        cgpaTextfield.delegate = self
    }
    
    func validateForm() -> Bool {
        if passingYearTextField.text!.isEmpty {
            showsimpleAlert(title: "Passing Year is empty", message: "You should fill all the blanks.")
            return false;
        }
        if cgpaTextfield.text!.isEmpty {
            showsimpleAlert(title: "Percentage/CGPA is empty", message: "You should fill all the blanks.")
            return false;
        }
        return true
    }
    
    func cleanForm() {
        passingYearTextField.text = ""
        cgpaTextfield.becomeFirstResponder()
    }
    
    func showSavedAlert() {
        let alert = UIAlertController(title: "Saved", message: "Your education is saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add Another", style: .default, handler: { [weak self] alert in
            self?.cleanForm()
        }))
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { [weak self] alert in
            self?.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func save() {
        if validateForm() == false {
            return
        }
        
        let education = EducationDetailsModal()
        education.className = classSegment.titleForSegment(at: classSegment.selectedSegmentIndex)
        education.passingYear = passingYearTextField.text
        education.percentageCGPA = cgpaTextfield.text
        
        delegate.educationAdded(education: education)
        showSavedAlert()
        
    }

    @IBAction func btnSaveTapped(_ sender: UIButton) {
        save()
    }
}

extension AddEducationViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passingYearTextField {
            cgpaTextfield.becomeFirstResponder()
        }
        if textField == cgpaTextfield {
            save()
        }
        return true
    }
}
