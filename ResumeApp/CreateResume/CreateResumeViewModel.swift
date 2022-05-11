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
    
    var hasUnsavedEdit = false;
    
    func onUIReady() {
        // fetch the data.
        DataProvider.getAllResumes {
            delegate.updateUI();
        }
    }
    
}
