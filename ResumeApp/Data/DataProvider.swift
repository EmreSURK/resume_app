//
//  DataProvider.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import Foundation


class DataProvider {
    static func getAllResumes( _ complation : @escaping () ->() )  {
        let jsonArray = UserDefaults.standard.array(forKey: UserDefaultsKeys.allResumes ) as? [String]
        
    }
}
