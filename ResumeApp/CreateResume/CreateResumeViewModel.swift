//
//  CreateResumeViewModel.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import Foundation


class CreateResumeViewModel : BaseViewModelProtocol  {
    
    var delegate : BaseViewModelDeletegate! = nil
    
    init( _ deletegate : BaseViewModelDeletegate ) {
        self.delegate = deletegate
    }
    
    var hasUnsavedEdit = true;
    
    func onUIReady() {
        // fetch the data.
        DataProvider.getAllResumes { [weak self] in
            self?.delegate.updateUI();
        }
    }
    
}
