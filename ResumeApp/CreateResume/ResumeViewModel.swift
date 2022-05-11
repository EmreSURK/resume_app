//
//  CreateResumeViewModel.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import Foundation


class ResumeViewModel : BaseViewModelProtocol  {
        
    var delegate : BaseViewModelDeletegate! = nil
    var resume : ResumeModal! = nil
    var isResumeLoadedFromDisk = false;
    var hasUnsavedEdit = true;
    var isInitialDataReady: Bool {
        get {
            isResumeLoadedFromDisk
        }
    }
    
    init( _ deletegate : BaseViewModelDeletegate ) {
        self.delegate = deletegate
    }
    
    
    
    func userUpdatedData() {
        hasUnsavedEdit = true
        delegate.updateUI()
    }
    
    func saveData() {
        DiskDataProvider.setResume(resume: resume)
        hasUnsavedEdit = false
        delegate.updateUI()
    }
    
    func onUIReady() {
        
        // we already set the data.
        if isInitialDataReady {
            return
        }
        
        // fetch the data.
        DiskDataProvider.getResume({  [weak self] resume in
            var resume = resume
            if resume == nil {
                resume = ResumeModal()
            }
            self?.resume = resume
            
            self?.isResumeLoadedFromDisk = true
            self?.delegate.updateUI();
        }) 
    }
    
}
