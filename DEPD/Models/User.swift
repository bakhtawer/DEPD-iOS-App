//
//  User.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/07/2024.
//

import Foundation

struct User: Codable {
    var id: Int?
    var userTypeId: Int?
    var subTypeId: Int?
    var firstName: String?
    var lastName: String?
    var cnic: String?
    var contactNo: String?
    var password: String?
    var isVerified: Bool?
    var language: String?
    var emailAddress: String?
    var percentage: Int?
    var oStudentDetails: StudentDetails?
    var oStudentApplicationDetail: [StudentApplication]?
    var schoolSocialMediaInfo: SchoolSocialMediaInfo?
    var schoolDetailInfo: SchoolDetailInfo?
    var schoolMultiMedia: SchoolMultiMedia?
    var jobSeekerDetailInfo: JobSeekerDetailInfo?
    var aboutInfo: AboutInfo?
    var jobSeekerEducation: [JobSeekerEducation]?
    var jobSeekerWorkExperience: [JobSeekerWorkExperience]?
    
    var companyDetailInfo: CompanyDetail?
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userTypeId = "UserTypeId"
        case subTypeId = "SubTypeId"
        case firstName = "FirstName"
        case lastName = "LastName"
        case cnic = "CNIC"
        case contactNo = "ContactNo"
        case password = "Password"
        case isVerified = "IsVerified"
        case language = "Language"
        case emailAddress = "EmailAddress"
        case oStudentDetails = "StudentDetailsInfo"
        case oStudentApplicationDetail
        case schoolSocialMediaInfo = "SchoolSocialMediaInfo"
        case schoolDetailInfo = "SchoolDetailInfo"
        case schoolMultiMedia = "SchoolMultiMediaList"
        case jobSeekerDetailInfo = "JobSeekerDetailInfo"
        case aboutInfo = "aboutinfo"
        case jobSeekerEducation = "JobSeekerEducation"
        case jobSeekerWorkExperience = "JobSeekerWorkExperience"
        case companyDetailInfo = "CompanyDetailInfo"
        case percentage = "Percentage"
    }
    
    init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            userTypeId = try container.decodeIfPresent(Int.self, forKey: .userTypeId) ?? -1
            subTypeId = try container.decodeIfPresent(Int.self, forKey: .subTypeId) ?? -1
            firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
            lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
            cnic = try container.decodeIfPresent(String.self, forKey: .cnic) ?? ""
            contactNo = try container.decodeIfPresent(String.self, forKey: .contactNo) ?? ""
            password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
            isVerified = try container.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
            language = try container.decodeIfPresent(String.self, forKey: .language)
            emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
            oStudentDetails = try container.decodeIfPresent(StudentDetails.self, forKey: .oStudentDetails)
            oStudentApplicationDetail = try container.decodeIfPresent([StudentApplication].self, forKey: .oStudentApplicationDetail)
            schoolSocialMediaInfo = try container.decodeIfPresent(SchoolSocialMediaInfo.self, forKey: .schoolSocialMediaInfo)
            schoolDetailInfo = try container.decodeIfPresent(SchoolDetailInfo.self, forKey: .schoolDetailInfo)
            schoolMultiMedia = try container.decodeIfPresent(SchoolMultiMedia.self, forKey: .schoolMultiMedia)
            jobSeekerDetailInfo = try container.decodeIfPresent(JobSeekerDetailInfo.self, forKey: .jobSeekerDetailInfo)
            aboutInfo = try container.decodeIfPresent(AboutInfo.self, forKey: .aboutInfo)
            jobSeekerEducation = try container.decodeIfPresent([JobSeekerEducation].self, forKey: .jobSeekerEducation)
            jobSeekerWorkExperience = try container.decodeIfPresent([JobSeekerWorkExperience].self, forKey: .jobSeekerWorkExperience)
            companyDetailInfo = try container.decodeIfPresent(CompanyDetail.self, forKey: .companyDetailInfo)
            percentage = try container.decodeIfPresent(Int.self, forKey: .percentage) ?? 0
            
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct StudentDetails: Codable {
    var id: Int?
    var studentId: Int?
    var fatherName: String?
    var fatherCnic: String?
    var dob: String?
    var formattedDOB: String?
    var genderId: Int?
    var gender: String?
    var formBURL: String?
    var address: String?
    var district: String?
    var disabilityStatusId: Int?
    var previousEducation: String?
    var profilePictureURL: String?
    var disabilityCertificateURL: String?
    var hasPPUploaded: Bool?
    var hasDisCertUploaded: Bool?
    var profilePercentage: Int?
    var profileCompletionPercentage: Int?
    var emailAddress: String?
    
    var profilePictureName: String?
    var profilePictureString: String?
    var disabilityCertificateString: String?
    var disabilityCertName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case studentId = "StudentId"
        case fatherName = "FatherName"
        case fatherCnic = "FatherCNIC"
        case dob = "DOB"
        case formattedDOB = "FormattedDOB"
        case genderId = "GenderId"
        case gender = "Gender"
        case formBURL = "FormBURL"
        case address = "Address"
        case district = "District"
        case disabilityStatusId = "DisabilityStatusId"
        case previousEducation = "PreviousEducation"
        case profilePictureURL = "ProfilePictureURL"
        case disabilityCertificateURL = "DisabilityCertificateURL"
        case hasPPUploaded = "HasPPUploaded"
        case hasDisCertUploaded = "HasDisCertUploaded"
        case profilePercentage = "ProfilePercentage"
        case profileCompletionPercentage = "ProfileCompletionPercentage"
        case emailAddress = "EmailAddress"
        case profilePictureString = "ProfilePictureBytesString"
        case disabilityCertificateString = "DisabilityCertBytesString"
        case profilePictureName = "ProfilePictureName"
        case disabilityCertName = "DisabilityCertName"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            studentId = try container.decodeIfPresent(Int.self, forKey: .studentId) ?? -1
            fatherName = try container.decodeIfPresent(String.self, forKey: .fatherName) ?? ""
            fatherCnic = try container.decodeIfPresent(String.self, forKey: .fatherCnic) ?? ""
            dob = try container.decodeIfPresent(String.self, forKey: .dob)
            formattedDOB = try container.decodeIfPresent(String.self, forKey: .formattedDOB)
            genderId = try container.decodeIfPresent(Int.self, forKey: .genderId) ?? -1
            gender = try container.decodeIfPresent(String.self, forKey: .gender) ?? ""
            formBURL = try container.decodeIfPresent(String.self, forKey: .formBURL)
            address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
            district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
            disabilityStatusId = try container.decodeIfPresent(Int.self, forKey: .disabilityStatusId) ?? -1
            previousEducation = try container.decodeIfPresent(String.self, forKey: .previousEducation)
            profilePictureURL = try container.decodeIfPresent(String.self, forKey: .profilePictureURL)
            disabilityCertificateURL = try container.decodeIfPresent(String.self, forKey: .disabilityCertificateURL)
            hasPPUploaded = try container.decodeIfPresent(Bool.self, forKey: .hasPPUploaded) ?? false
            hasDisCertUploaded = try container.decodeIfPresent(Bool.self, forKey: .hasDisCertUploaded) ?? false
            profilePercentage = try container.decodeIfPresent(Int.self, forKey: .profilePercentage) ?? 0
            profileCompletionPercentage = try container.decodeIfPresent(Int.self, forKey: .profileCompletionPercentage) ?? 0
            emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
            profilePictureString = try container.decodeIfPresent(String.self, forKey: .profilePictureString)
            disabilityCertificateString = try container.decodeIfPresent(String.self, forKey: .disabilityCertificateString)
            profilePictureName = try container.decodeIfPresent(String.self, forKey: .profilePictureName)
            disabilityCertName = try container.decodeIfPresent(String.self, forKey: .disabilityCertName)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct StudentApplication: Codable {
    var id: Int?
    var schoolName: String?
    var appliedOnDate: String?
    var className: String?
    var admissionStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case schoolName = "SchoolName"
        case appliedOnDate = "AppliedOnDate"
        case className = "ClassName"
        case admissionStatus = "AdmissionStatus"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? ""
            appliedOnDate = try container.decodeIfPresent(String.self, forKey: .appliedOnDate)
            className = try container.decodeIfPresent(String.self, forKey: .className) ?? ""
            admissionStatus = try container.decodeIfPresent(String.self, forKey: .admissionStatus) ?? "pending".localized()
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct SchoolSocialMediaInfo: Codable {
    var id: Int?
    var AccountTypeID: Int?
    var RelID: Int?
    var SocialMediaLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case AccountTypeID = "AccountTypeID"
        case RelID = "RelID"
        case SocialMediaLink = "SocialMediaLink"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            AccountTypeID = try container.decodeIfPresent(Int.self, forKey: .AccountTypeID) ?? -1
            RelID = try container.decodeIfPresent(Int.self, forKey: .RelID) ?? -1
            SocialMediaLink = try container.decodeIfPresent(String.self, forKey: .SocialMediaLink) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func convertUrl() -> String {
        let link = self.SocialMediaLink ?? ""
        if link.contains("facebook") {
            return "https://cdn.pixabay.com/photo/2021/06/15/12/51/facebook-6338507_1280.png"
        }
        
        if link.contains("youtube") {
            return "https://www.iconpacks.net/icons/2/free-youtube-logo-icon-2431-thumb.png"
        }
        
        if link.contains("instagram") {
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNDSc2kBojlcAsXp4YYp4MJQHHizDnPuvP7g&s"
        }
        
        if link.contains("x") || link.contains("twiter") {
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmTwnA_cbtpvYtWYfPtisBpkedtXxX0Xy6fQ&s"
        }
        
        if link.contains("linkdin") {
            return "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.com%2Ffree-icon%2Flinkedin_174857&psig=AOvVaw1VKZHV-49H9ei-shW-3ygs&ust=1733855840833000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLjVw72qm4oDFQAAAAAdAAAAABAE"
        }
        
        return ""
    }
}

struct SchoolDetailInfo: Codable {
    let id: Int?
    let schoolId: Int?
    let schoolName: String?
    let emailAddress: String?
    let ntnNumber: String?
    let designation: String?
    let aboutText: String?
    let establishedYear: Int?
    let location: String?
    let availableSeats: Int?
    let numberOfTrainedTeachers: Int?
    let lastUpdated: String?
    let schoolTypeId: Int?
    let profileImageURL: String?
    let profileImageBytesString: String?
    let profileImageName: String?
    let hasTrainingMaterial: Bool?
    let hasAccessibilityMaterial: Bool?
    let numberOfTotalStudents: Int?
    let freeOrPaid: Int?
    let canEducate: Bool?
    let district: String?
    
    
    var SchoolMultiMediaList: [SchoolMultiMedia]?
    var DisabilityStatusList: [Disability]?
    var SchoolDisabilityList: [SchoolDisability]?
    var schoolSocialMediaInfo: [SchoolSocialMediaInfo]?
    var AccebilityMaterialListInfo: [AccebilityMaterial]?
    var TrainingMaterialList: [TrainingMaterial]?
    var schoolAndCompanyDisabilityStatusInfo: [DisabilityStatusCompany]?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case schoolId = "SchoolId"
        case schoolName = "SchoolName"
        case emailAddress = "EmailAddress"
        case ntnNumber = "NTNNumber"
        case designation = "Designation"
        case aboutText = "AboutText"
        case establishedYear = "EstablishedYear"
        case location = "Location"
        case availableSeats = "AvailableSeats"
        case numberOfTrainedTeachers = "NumberOfTrainedTeachers"
        case lastUpdated = "LastUpdated"
        case schoolTypeId = "SchoolTypeId"
        case profileImageURL = "ProfileImageURL"
        case profileImageBytesString = "ProfileImageBytesString"
        case profileImageName = "ProfileImageName"
        case hasTrainingMaterial = "HasTrainingMaterial"
        case hasAccessibilityMaterial = "HasAccessibilityMaterial"
        case numberOfTotalStudents = "NumberOfTotalStudents"
        case freeOrPaid = "FreeOrPaid"
        case canEducate = "CanEducate"
        case district = "District"
        case SchoolMultiMediaList = "SchoolMultiMedia"
        case DisabilityStatusList = "oDisabilityStatusList"
        case SchoolDisabilityList = "oSchoolDisabilityList"
        case schoolSocialMediaInfo = "SchoolSocialMediaInfo"
        case AccebilityMaterialListInfo = "AccebilityMaterialListInfo"
        case TrainingMaterialList = "TrainingMaterialList"
        case schoolAndCompanyDisabilityStatusInfo = "SchoolAndCompanyDisabilityStatusInfo"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decoding and providing default values if key is missing or nil
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        schoolId = try container.decodeIfPresent(Int.self, forKey: .schoolId) ?? -1
        schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? ""
        emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress) ?? ""
        ntnNumber = try container.decodeIfPresent(String.self, forKey: .ntnNumber) ?? ""
        designation = try container.decodeIfPresent(String.self, forKey: .designation) ?? ""
        aboutText = try container.decodeIfPresent(String.self, forKey: .aboutText) ?? "N/A"
        establishedYear = try container.decodeIfPresent(Int.self, forKey: .establishedYear) ?? 0
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        availableSeats = try container.decodeIfPresent(Int.self, forKey: .availableSeats) ?? 0
        numberOfTrainedTeachers = try container.decodeIfPresent(Int.self, forKey: .numberOfTrainedTeachers) ?? 0
        lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated) ?? ""
        schoolTypeId = try container.decodeIfPresent(Int.self, forKey: .schoolTypeId) ?? 0
        profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL) ?? ""
        profileImageBytesString = try container.decodeIfPresent(String.self, forKey: .profileImageBytesString) ?? ""
        profileImageName = try container.decodeIfPresent(String.self, forKey: .profileImageName) ?? ""
        hasTrainingMaterial = try container.decodeIfPresent(Bool.self, forKey: .hasTrainingMaterial) ?? false
        hasAccessibilityMaterial = try container.decodeIfPresent(Bool.self, forKey: .hasAccessibilityMaterial) ?? false
        numberOfTotalStudents = try container.decodeIfPresent(Int.self, forKey: .numberOfTotalStudents) ?? 0
        freeOrPaid = try container.decodeIfPresent(Int.self, forKey: .freeOrPaid) ?? 0
        canEducate = try container.decodeIfPresent(Bool.self, forKey: .canEducate) ?? false
        district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
        SchoolMultiMediaList = try container.decodeIfPresent([SchoolMultiMedia].self, forKey: .SchoolMultiMediaList) ?? []
        DisabilityStatusList = try container.decodeIfPresent([Disability].self, forKey: .DisabilityStatusList) ?? []
        SchoolDisabilityList = try container.decodeIfPresent([SchoolDisability].self, forKey: .SchoolDisabilityList) ?? []
        schoolSocialMediaInfo = try container.decodeIfPresent([SchoolSocialMediaInfo].self, forKey: .schoolSocialMediaInfo) ?? []
        AccebilityMaterialListInfo = try container.decodeIfPresent([AccebilityMaterial].self, forKey: .AccebilityMaterialListInfo) ?? []
        TrainingMaterialList = try container.decodeIfPresent([TrainingMaterial].self, forKey: .TrainingMaterialList) ?? []
        schoolAndCompanyDisabilityStatusInfo = try container.decodeIfPresent([DisabilityStatusCompany].self, forKey: .schoolAndCompanyDisabilityStatusInfo) ?? []
    }
}


struct CompanyDetail: Codable {
    var id:Int?
    var companyId:Int?
    var companyName:String?
    var companyImageURL:String?
    var emailAdress:String?
    var nTNNumber:String?
    var contactNumber:String?
    var designation:String?
    var registirationNumber:String?
    var location:String?
    var lastUpdated:String?
    var firstName:String?
    var lastName:String?
    var cNIC:String?
    var aboutDescription:String?
    var availableQuotaForPWDs:String?
    var website:String?
    var district:String?
    var socialMedia: [SchoolSocialMediaInfo]?
    var schoolAndCompanyDisabilityStatusInfo: [DisabilityStatusCompany]?
    var accessibilityMaterialListInfo: [AllListData]?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case companyId = "CompanyId"
        case companyName = "CompanyName"
        case companyImageURL = "CompanyImageURL"
        case emailAdress = "EmailAdress"
        case nTNNumber = "NTNNumber"
        case contactNumber = "ContactNumber"
        case designation = "Designation"
        case registirationNumber = "RegistirationNumber"
        case location = "Location"
        case lastUpdated = "LastUpdated"
        case firstName = "FirstName"
        case lastName = "LastName"
        case cNIC = "CNIC"
        case aboutDescription = "Description"
        case availableQuotaForPWDs = "AvailableQuotaForPWDs"
        case website = "Website"
        case district = "District"
        case socialMedia = "osocialMedia"
        case schoolAndCompanyDisabilityStatusInfo = "OSchoolAndCompanyDisabilityStatusInfo"
        case accessibilityMaterialListInfo = "oAccebilityMaterialListInfo"
    }
    
    init
    (from decoder: Decoder) throws {
        do {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decoding and providing default values if key is missing or nil
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        companyId = try container.decodeIfPresent(Int.self, forKey: .companyId) ?? -1
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName) ?? ""
        companyImageURL = try container.decodeIfPresent(String.self, forKey: .companyImageURL) ?? ""
        emailAdress = try container.decodeIfPresent(String.self, forKey: .emailAdress) ?? ""
        nTNNumber = try container.decodeIfPresent(String.self, forKey: .nTNNumber) ?? ""
        contactNumber = try container.decodeIfPresent(String.self, forKey: .contactNumber) ?? ""
        designation = try container.decodeIfPresent(String.self, forKey: .designation) ?? ""
        registirationNumber = try container.decodeIfPresent(String.self, forKey: .registirationNumber) ?? ""
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated) ?? ""
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        cNIC = try container.decodeIfPresent(String.self, forKey: .cNIC) ?? ""
        aboutDescription = try container.decodeIfPresent(String.self, forKey: .aboutDescription) ?? "N/A"
        availableQuotaForPWDs = try container.decodeIfPresent(String.self, forKey: .availableQuotaForPWDs) ?? ""
        website = try container.decodeIfPresent(String.self, forKey: .website) ?? ""
        district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
        socialMedia = try container.decodeIfPresent([SchoolSocialMediaInfo].self, forKey: .socialMedia) ??  []
        schoolAndCompanyDisabilityStatusInfo = try container.decodeIfPresent([DisabilityStatusCompany].self, forKey: .schoolAndCompanyDisabilityStatusInfo) ?? []
        accessibilityMaterialListInfo = try container.decodeIfPresent([AllListData].self, forKey: .accessibilityMaterialListInfo) ?? []
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}


struct DisabilityStatusCompany: Codable {
    var id: Int?
    var userId: Int?
    var disabilityStatusId: Int?
    var disabilityStatus : String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userId = "userId"
        case disabilityStatusId = "disabilityStatusId"
        case disabilityStatus = "disabilityStatus"
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
            userId = try values.decodeIfPresent(Int.self, forKey: .userId) ?? -1
            disabilityStatusId = try values.decodeIfPresent(Int.self, forKey: .disabilityStatusId) ?? -1
            disabilityStatus = try values.decodeIfPresent(String.self, forKey: .disabilityStatus) ?? ""
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

struct StudentUpdateDetails: Codable {
    let Id: Int?
    let FirstName: String?
    let LastName: String?
    let ContactNo: String?
    let oStudentDetails: StudentDetails?
    struct StudentDetails: Codable {
        let FatherName: String?
        let FatherCNIC: String?
        let DisabilityStatusId: Int?
        let ProfilePictureURL: String?
        let DisabilityCertificateURL: String?
        let ProfilePictureBytesString: String?
        let ProfilePictureName: String?
        let DisabilityCertBytesString: String?
        let DisabilityCertName: String?
        let Address: String?
        let District: String?
        let DOB: String?
        let PreviousEducation: String?
        let GenderId: Int?
        let EmailAddress:String?
    }
}
