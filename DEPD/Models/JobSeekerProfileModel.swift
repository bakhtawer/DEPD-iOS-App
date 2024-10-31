//
//  JobSeekerProfileModel.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 31/10/2024.
//

import Foundation

struct JobSeekerProfileModel {
    var name: String
    var location: String
    var email: String
    var cnic: String
    var contactNumber: String
    var education: [Education]
    var technicalSkills: [String]
    var certifications: [Certification]
    var languages: [String]
    var disabilityCertificate: String
    var disabilityStatus: String
    var profileImage: String
    
    func getUserProfileUrl() -> URL {
        URL(string: self.profileImage)!
    }
}

struct Education {
    var institution: String
    var degree: String
    var years: String
}

struct Certification {
    var institution: String
    var title: String
    var years: String
}
