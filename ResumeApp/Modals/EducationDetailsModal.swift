//
//  EducationDetailsModal.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import Foundation


class EducationDetailsModal: Codable {
    var className : String?
    // I leave them as string since different countries may have different standarts. 
    var passingYear : String?
    var percentageCGPA : String?
}
