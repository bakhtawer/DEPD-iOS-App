//
//  District.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 25/08/2024.
//

import Foundation

struct District: Codable {
    var districtId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case districtId = "Id"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            districtId = try values.decodeIfPresent(Int.self, forKey: .districtId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Disability: Codable {
    var disabilityId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case disabilityId = "Id"
        case name = "DisabilityName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            disabilityId = try values.decodeIfPresent(Int.self, forKey: .disabilityId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Gender: Codable {
    var genderId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case genderId = "Id"
        case name = "GenderName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            genderId = try values.decodeIfPresent(Int.self, forKey: .genderId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Designations: Codable {
    var designationId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case designationId = "Id"
        case name = "DesignationName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            designationId = try values.decodeIfPresent(Int.self, forKey: .designationId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Classes: Codable {
    var peId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case peId = "Id"
        case name = "ClassName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            peId = try values.decodeIfPresent(Int.self, forKey: .peId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct AllGeneralList: Codable {
    var classList: [Classes]?
    var accessibilityList: [AllListData]?
    var trainingList: [AllListData]?
    var GenderList: [Gender]?
    var DesignationList: [Designations]?
    var DisabilityList: [Disability]?
    var DistrictList: [District]?
    var DegreeProgram: [Degree]?
    var TechnicalSkillList: [SkillSet]?
    var userTypeList: [UserTypeList]?
    var languageList: [LanguageList]?
    var socialMediaList: [SocialMediaList]?
    var isError: Bool?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case classList = "oClassList"
        case accessibilityList = "oAccebilityList"
        case trainingList = "oTrainingList"
        case GenderList = "oGenderList"
        case DesignationList = "oDesignationList"
        case DisabilityList = "oDisabilityList"
        case DistrictList = "oDistrictList"
        case DegreeProgram = "oDegreeProgram"
        case TechnicalSkillList = "oTechnicalSkillList"
        case userTypeList = "oUserTypeList"
        case languageList = "oLanguageList"
        case socialMediaList = "oSocialMediaList"
        case isError = "IsError"
        case errorMessage = "ErrorMessage"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            classList = try values.decodeIfPresent([Classes].self, forKey: .classList) ?? []
            accessibilityList = try values.decodeIfPresent([AllListData].self, forKey: .accessibilityList) ?? []
            trainingList = try values.decodeIfPresent([AllListData].self, forKey: .trainingList) ?? []
            GenderList = try values.decodeIfPresent([Gender].self, forKey: .GenderList) ?? []
            DesignationList = try values.decodeIfPresent([Designations].self, forKey: .DesignationList) ?? []
            DisabilityList = try values.decodeIfPresent([Disability].self, forKey: .DisabilityList) ?? []
            DistrictList = try values.decodeIfPresent([District].self, forKey: .DistrictList) ?? []
            DegreeProgram = try values.decodeIfPresent([Degree].self, forKey: .DegreeProgram) ?? []
            TechnicalSkillList = try values.decodeIfPresent([SkillSet].self, forKey: .TechnicalSkillList) ?? []
            userTypeList = try values.decodeIfPresent([UserTypeList].self, forKey: .userTypeList) ?? []
            languageList = try values.decodeIfPresent([LanguageList].self, forKey: .languageList) ?? []
            socialMediaList = try values.decodeIfPresent([SocialMediaList].self, forKey: .socialMediaList) ?? []
            isError = try values.decodeIfPresent(Bool.self, forKey: .isError) ?? false
            errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct AllListData: Codable {
    var mId: Int?
    var schoolId: Int?
    var materialId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case mId = "Id"
        case schoolId = "SchoolId"
        case materialId = "MaterialId"
        case name = "MaterialName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mId = try values.decodeIfPresent(Int.self, forKey: .mId) ?? -1
            schoolId = try values.decodeIfPresent(Int.self, forKey: .schoolId) ?? -1
            materialId = try values.decodeIfPresent(Int.self, forKey: .materialId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct Degree: Codable {
    var mId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case mId = "Id"
        case name = "DegreeName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mId = try values.decodeIfPresent(Int.self, forKey: .mId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct SkillSet: Codable {
    var mId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case mId = "Id"
        case name = "SkillName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mId = try values.decodeIfPresent(Int.self, forKey: .mId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct UserTypeList: Codable {
    var mId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case mId = "Id"
        case name = "UserTypeName"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mId = try values.decodeIfPresent(Int.self, forKey: .mId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct LanguageList: Codable {
    var mId : Int?
    var name : String?
    enum CodingKeys: String, CodingKey {
        case mId = "Id"
        case name = "Name"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mId = try values.decodeIfPresent(Int.self, forKey: .mId) ?? -1
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct SocialMediaList: Codable {
    var mId : Int?
    var accountType : String?
    var link : String?
    enum CodingKeys: String, CodingKey {
        case mId = "Id"
        case accountType = "AccountType"
        case link = "Link"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            mId = try values.decodeIfPresent(Int.self, forKey: .mId) ?? -1
            accountType = try values.decodeIfPresent(String.self, forKey: .accountType) ?? ""
            link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
