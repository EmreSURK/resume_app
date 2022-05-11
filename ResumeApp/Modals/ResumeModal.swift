//
//  ResumeModal.swift
//  ResumeApp
//
//  Created by Emre on 11.05.2022.
//

import Foundation

class ResumeModal : Codable {
    var phoneNumber : String?
    var emailAdress : String?
    var residenceAddress : String?
    var careerObjective : String?
    var totalYearsOfExperience : Int?
    var workSummary : String?
    var skills : [String] = []
    var educationDetails : [EducationDetailsModal] = []
    var projectDetails : [ProjectDetailsModal] = []
}
