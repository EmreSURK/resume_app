//
//  AddWorkSummaryViewController.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import UIKit

class AddSkillViewController: BaseViewController {

    static func present( sender : UIViewController, delegate : AddSkillDelegate ) {
        let vc = AddSkillViewController(nibName: AddSkillViewController.className, bundle: nil)
        vc.delegate = delegate
        sender.present(vc, animated: true)
    }
    
    
    @IBOutlet weak var skillNameTextField: UITextField!
    
    var delegate : AddSkillDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        skillNameTextField.delegate = self
        skillNameTextField.accessibilityIdentifier = "skill name"
    }
    
    func validateForm() -> Bool {
        if skillNameTextField.text!.isEmpty {
            showsimpleAlert(title: "Skill is empty", message: "You should fill all the blanks.")
            return false;
        }
                return true
    }
    
    func cleanForm() {
        skillNameTextField.text = ""
        skillNameTextField.becomeFirstResponder()
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
        
        
        delegate.skillAdded(skill: skillNameTextField.text!)
        showSavedAlert()
        
    }

    @IBAction func btnSaveTapped(_ sender: UIButton) {
        save()
    }
}

extension AddSkillViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == skillNameTextField {
            save()
        }
        return true
    }
}
