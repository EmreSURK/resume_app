//
//  DataProvider.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import Foundation


class DiskDataProvider {
    static func getResume( _ complation : @escaping ( _ resume : ResumeModal? ) ->() )  {
        let jsonString = UserDefaults.standard.string(forKey: UserDefaultsKey.resume )
        
        // I used early-exit pattern to keep code lean.
        guard let jsonString = jsonString else {
            complation(nil);
            return;
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            complation(nil)
            return
        }
        
        let resume = try? JSONDecoder().decode(ResumeModal.self, from: jsonData)
        complation(resume)
        
    }
    
    static func setResume( resume : ResumeModal ) {
        let resumeData =  try! JSONEncoder().encode(resume)
        let resumeJsonString =  String(data: resumeData, encoding: .utf8)
        UserDefaults.standard.set(resumeJsonString, forKey: UserDefaultsKey.resume )
        print("data on disk is updated")
    }
}
