//
//  AddWorkSummaryViewController.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import UIKit

class AddWorkSummaryViewController: BaseViewController {

    static func present( sender : UIViewController, delegate : AddWorkSummaryDelegate ) {
        let vc = AddWorkSummaryViewController(nibName: AddWorkSummaryViewController.className, bundle: nil)
        vc.delegate = delegate
        sender.present(vc, animated: true)
    }
    
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    var delegate : AddWorkSummaryDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        companyNameTextField.delegate = self
        durationTextField.delegate = self
    }
    
    func validateForm() -> Bool {
        if companyNameTextField.text!.isEmpty {
            showsimpleAlert(title: "Company name is empty", message: "You should fill all the blanks.")
            return false;
        }
        
        if durationTextField.text!.isEmpty {
            showsimpleAlert(title: "Duration is empty", message: "You should fill all the blanks.")
            
            return false;
        }
        return true
    }
    
    func cleanForm() {
        companyNameTextField.text = ""
        durationTextField.text = ""
        companyNameTextField.becomeFirstResponder()
    }
    
    func showSavedAlert() {
        let alert = UIAlertController(title: "Saved", message: "Your work summary is saved.", preferredStyle: .alert)
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
        
        let summary = WorkSummaryModal()
        summary.companyName = companyNameTextField.text
        summary.duration = durationTextField.text
        
        delegate.summaryAdded(summary: summary)
        showSavedAlert()
        
    }

    @IBAction func btnSaveTapped(_ sender: UIButton) {
        save()
    }
}

extension AddWorkSummaryViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == companyNameTextField {
            durationTextField.becomeFirstResponder()
        }
        if textField == durationTextField {
            save()
        }
        return true
    }
}
