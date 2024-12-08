//
//  Endpoint.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct LoginCredentials: Codable {
    let CNIC: String
    let Password: String
}

struct ApplySchool: Codable {
    let SchoolId: Int
    let StudentId: Int
}

struct UpdateAboutYourSchoolCreds: Codable {
    let SchoolId: Int
    let AboutText: String
}

struct UpdateAdditionalInfoCreds: Codable {
    let SchoolId: Int
    let EstablishedYear: String
    let Location: String
    let District: String
    let NumberOfTrainedTeachers: Int
    let HasTrainingMaterial: Int
    let NumberOfTotalStudents: Int
    let CanEducate: Int
    let FreeOrPaid: Int
}

struct InsertSocialMediaLinkCreds: Codable {
    let AccountTypeID: Int
    let RelID: Int
    let SocialMediaLink: String
}

struct InsertDisabilityStatusCreds: Codable {
    let DisabilityStatusId: Int
    let UserId: Int
}

struct GetUserByID: Codable {
    var Id: Int
}
 
enum Endpoint {
    
    case login(url: String = "/api/auth.ashx",
               email: String,
               password: String)
    case register(url: String = "/api/auth.ashx",
                  creds: SignUpCredentials)
    
    case getUser(cred: GetUserByID)
    
    case allGeneralList
    
    case getSchoolList
    case applyForSchool(schoolID: Int, studentId: Int)
    
    case getStudentAdmissions(schoolID: Int, studentId: Int)
    
    case updatePersonalInfo(url: String = "/api/School.ashx",
                               creds: SchoolInfoCredentials)
    case UpdateAboutYourSchool(url: String = "/api/School.ashx",
                               creds: UpdateAboutYourSchoolCreds)
    case UpdateAdditionalInfo(url: String = "/api/School.ashx",
                               creds: UpdateAdditionalInfoCreds)
    case InsertSocialMediaLink(url: String = "/api/School.ashx",
                               creds: InsertSocialMediaLinkCreds)
    case InsertDisabilityStatus(url: String = "/api/School.ashx",
                               creds: InsertDisabilityStatusCreds)
    
    
    // Job
    case getJobList
    case applyForJob(creds: ApplyForJobCreds)
    case updateOrInsertJobSeekerDetail(creds: UpdateOrInsertJobSeekerDetailCreds)
    case insertJobSeekerAdditionalInfo(creds: InsertJobSeekerAdditionalInfoCreds)
    case getJobSeekerCertifications(creds: GetJobSeekerCertificationsCreds)
    case getJobSeekerTechnicalSkills(creds: GetJobSeekerTechnicalSkillsCreds)
    case insertJobSeekerTechnicalSkills(creds: InsertJobSeekerTechnicalSkillsCreds)
    case insertJobSeekerEducation(creds: InsertJobSeekerEducationCreds)
    case insertJobSeekerWorkExperience(creds: InsertJobSeekerWorkExperienceCreds)
    case updateJobSeekerCertifications(creds: UpdateJobSeekerCertificationsCreds)
    case uploadJobSeekerProfileImage(creds: UploadJobSeekerProfileImageCreds)
    case uploadJobSeekerCV(creds: UploadJobSeekerCVCreds)
    case uploadDisabilityCertificate(creds: UploadDisabilityCertificateCreds)
    case updatePersonalInformationJob(creds: UpdatePersonalInformationJobCreds)
    case deleteJobSeekerEducationSkills(creds: DeleteJobSeekerCreds)
    case deleteJobSeekerWorkExperience(creds: DeleteJobSeekerCreds)
    case deleteJobSeekerCertification(creds: DeleteJobSeekerCreds)
    case deleteJobSeekerTechnicalSkills(creds: DeleteJobSeekerCreds)
    case deleteJobSeekerAdditionalInfo(creds: DeleteJobSeekerCreds)
    
    case fetchPosts(url: String = "/posts")
    case fetchOnePost(url: String = "/posts", postId: Int = 1)
    case sendPost(url: String = "/posts", post: Post)
    
    
    case updateProfile(url: String = "/api/profile.ashx",
                       creds: StudentUpdateDetails)
    
    

    // School
    case uploadSchoolProfile(cred: UploadSchoolProfile)
    case updatePersonalInformation(cred: UpdatePersonalInformation)
    case updateAboutYourSchool(cred: UpdateAboutYourSchool)
    case updateAdditionalInfo(cred: UpdateAdditionalInfoCreds)
    case insertSocialMediaLink(cred: InsertSocialMediaLink)
    case deleteSocialMediaLink(cred: DeleteById)
    case insertSocialMultiMedia(cred: InsertSocialMultiMedia)
    case deleteSocialMultiMediaLink(cred: DeleteById)
    case insertDisabilityStatus(cred: InsertDisabilityStatus)
    case deleteDisabilityStatus(cred: DeleteById)
    case studentAdmissionUpdate(cred: StudentAdmissionUpdateCred)
    
    
    // Employer
    case uploadEmployerProfile(cred: UploadSchoolProfile)
    case updateEmployerPersonalInformation(cred: UpdatePersonalInformation)
    case insertEmployerSocialMediaLink(cred: InsertSocialMediaLink)
    case deleteEmployerSocialMediaLink(cred: DeleteById)
    case insertEmployerDisabilityStatus(cred: InsertDisabilityStatus)
    case deleteEmployerDisabilityStatus(cred: DeleteById)
    case insertEmployerAccessibilityStatus(cred: InsertDisabilityStatus)
    case deleteEmployerAccessibilityStatus(cred: DeleteById)
    
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseURL
        components.port = NetworkConstants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchPosts(let url): return url
        case .fetchOnePost(let url, let postId): return "\(url)/\(postId.description)"
        case .sendPost(let url, _): return url
        case .login(url: let url, _, _): return url
        case .register(let url, _): return url
        case .updatePersonalInfo(let url, _),
             .UpdateAboutYourSchool(let url, _),
             .UpdateAdditionalInfo(let url, _),
             .InsertSocialMediaLink(let url, _),
             .InsertDisabilityStatus(let url, _): return url
        case .getStudentAdmissions: return "/Api/General.ashx"
        case .getSchoolList, .applyForSchool, .allGeneralList: return "/Api/school.ashx"
        case .updateProfile: return "/Api/profile.ashx"
        case .uploadSchoolProfile, .updatePersonalInformation, .updateAboutYourSchool,.updateAdditionalInfo,
            .insertSocialMediaLink, .deleteSocialMediaLink, .insertSocialMultiMedia, .deleteSocialMultiMediaLink,
            .insertDisabilityStatus, .deleteDisabilityStatus,
            .studentAdmissionUpdate:
            return "/Api/school.ashx"
        case .getJobList, .applyForJob, .updateOrInsertJobSeekerDetail, .getJobSeekerCertifications,
                .getJobSeekerTechnicalSkills, .insertJobSeekerTechnicalSkills,
                .insertJobSeekerEducation, .insertJobSeekerWorkExperience, .updateJobSeekerCertifications,
                .uploadJobSeekerProfileImage,.uploadJobSeekerCV, .uploadDisabilityCertificate,
                .updatePersonalInformationJob, .insertJobSeekerAdditionalInfo:
            return "/Api/job.ashx"
        case .deleteJobSeekerEducationSkills, .deleteJobSeekerWorkExperience,
                .deleteJobSeekerCertification, .deleteJobSeekerAdditionalInfo,
                .deleteJobSeekerTechnicalSkills:
            return "/Api/profile.ashx"
        case .getUser:
            return "/Api/auth.ashx"
        case .uploadEmployerProfile, .updateEmployerPersonalInformation,
                .insertEmployerSocialMediaLink, .deleteEmployerSocialMediaLink,
                .insertEmployerDisabilityStatus, .deleteEmployerDisabilityStatus,
                .insertEmployerAccessibilityStatus,
                .deleteEmployerAccessibilityStatus:
            return "/Api/Employer.ashx"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .login: return [URLQueryItem(name: "method", value: "login")]
        case .register: return [URLQueryItem(name: "method", value: "register")]
        case .getSchoolList: return [URLQueryItem(name: "method", value: "getSchoolList")]
        case .applyForSchool: return [URLQueryItem(name: "method", value: "applyForSchool")]
        case .allGeneralList: return [URLQueryItem(name: "method", value: "AllGerenalList")]
        case .getStudentAdmissions: return [URLQueryItem(name: "method", value: "getStudentAdmissions")]
        case .fetchPosts: return []
        case .fetchOnePost: return []
        case .sendPost: return []
        case .updatePersonalInfo: return [URLQueryItem(name: "method", value: "UpdatePersonalInformation")]
        case .UpdateAboutYourSchool:
            return [URLQueryItem(name: "method", value: "UpdateAboutYourSchool")]
        case .UpdateAdditionalInfo:
            return [URLQueryItem(name: "method", value: "UpdateAdditionalInfo")]
        case .InsertSocialMediaLink:
            return [URLQueryItem(name: "method", value: "InsertSocialMediaLink")]
        case .InsertDisabilityStatus:
            return [URLQueryItem(name: "method", value: "InsertDisabilityStatus")]
        
        case .updateProfile: return [URLQueryItem(name: "method", value: "updateprofile")]
        case .uploadSchoolProfile: return [URLQueryItem(name: "method", value: "UploadSchoolProfile")]
        case .updatePersonalInformation: return [URLQueryItem(name: "method", value: "UpdatePersonalInformation")]
        case .updateAboutYourSchool: return [URLQueryItem(name: "method", value: "UpdateAboutYourSchool")]
        case .updateAdditionalInfo: return [URLQueryItem(name: "method", value: "UpdateAdditionalInfo")]
        case .insertSocialMediaLink: return [URLQueryItem(name: "method", value: "InsertSocialMediaLink")]
        case .deleteSocialMediaLink: return [URLQueryItem(name: "method", value: "DeleteSocialMediaLink")]
        case .insertSocialMultiMedia: return [URLQueryItem(name: "method", value: "InsertSocialMultiMedia")]
        case .deleteSocialMultiMediaLink: return [URLQueryItem(name: "method", value: "DeleteSocialMultiMediaLink")]
        case .insertDisabilityStatus: return [URLQueryItem(name: "method", value: "InsertDisabilityStatus")]
        case .deleteDisabilityStatus: return [URLQueryItem(name: "method", value: "DeleteDisabilityStatus")]
        // Job
        case .getJobList: return [URLQueryItem(name: "method", value: "getJobList")]
        case .applyForJob: return [URLQueryItem(name: "method", value: "applyForJob")]
        case .updateOrInsertJobSeekerDetail:
            return [URLQueryItem(name: "method", value: "updateOrInsertJobSeekerDetail")]
        case .getJobSeekerCertifications:
            return [URLQueryItem(name: "method", value: "getJobSeekerCertifications")]
        case .getJobSeekerTechnicalSkills:
            return [URLQueryItem(name: "method", value: "getJobSeekerTechnicalSkills")]
        case .insertJobSeekerTechnicalSkills:
            return [URLQueryItem(name: "method", value: "insertJobSeekerTechnicalSkills")]
        case .deleteJobSeekerTechnicalSkills:
            return [URLQueryItem(name: "method", value: "deleteJobSeekerTechnicalSkills")]
        case .insertJobSeekerEducation:
            return [URLQueryItem(name: "method", value: "insertJobSeekerEducation")]
        case .insertJobSeekerWorkExperience:
            return [URLQueryItem(name: "method", value: "insertJobSeekerWorkExperience")]
        case .updateJobSeekerCertifications:
            return [URLQueryItem(name: "method", value: "updateJobSeekerCertifications")]
        case .uploadJobSeekerProfileImage:
            return [URLQueryItem(name: "method", value: "uploadJobSeekerProfileImage")]
        case .uploadJobSeekerCV:
            return [URLQueryItem(name: "method", value: "uploadJobSeekerCV")]
        case .uploadDisabilityCertificate:
            return [URLQueryItem(name: "method", value: "uploadDisabilityCertificate")]
        case .updatePersonalInformationJob:
            return [URLQueryItem(name: "method", value: "updatePersonalInfo")]
        case .deleteJobSeekerEducationSkills:
            return [URLQueryItem(name: "method", value: "deletejobSeekerEducationExperience")]
        case .deleteJobSeekerWorkExperience:
            return [URLQueryItem(name: "method", value: "deletejobSeekerWorkExperience")]
        case .deleteJobSeekerCertification:
            return [URLQueryItem(name: "method", value: "deleteJobSeekerCertifications")]
        case .deleteJobSeekerAdditionalInfo:
            return [URLQueryItem(name: "method", value: "deleteJobSeekerAdditionalInfo")]
        case .insertJobSeekerAdditionalInfo:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .getUser:
            return [URLQueryItem(name: "method", value: "GetUserProfile")]
        case .studentAdmissionUpdate:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .uploadEmployerProfile:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .updateEmployerPersonalInformation:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .insertEmployerSocialMediaLink:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .deleteEmployerSocialMediaLink:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .insertEmployerDisabilityStatus:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .deleteEmployerDisabilityStatus:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .insertEmployerAccessibilityStatus:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        case .deleteEmployerAccessibilityStatus:
            return [URLQueryItem(name: "method", value: "insertJobSeekerAdditionalInfo")]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchPosts,
             .fetchOnePost,
             .getSchoolList, .allGeneralList:
            return HTTP.Method.get.rawValue
        case .sendPost, .login, .register,
            .applyForSchool,
            .getStudentAdmissions,
            .updatePersonalInfo, .UpdateAboutYourSchool, 
            .UpdateAdditionalInfo, .InsertSocialMediaLink,
            .InsertDisabilityStatus, .getJobList, .updateProfile,
            .uploadSchoolProfile, .updatePersonalInformation, .updateAboutYourSchool,.updateAdditionalInfo,
            .insertSocialMediaLink, .deleteSocialMediaLink, .insertSocialMultiMedia, .deleteSocialMultiMediaLink,
            .insertDisabilityStatus, .deleteDisabilityStatus, .applyForJob, .deleteJobSeekerAdditionalInfo:
            return HTTP.Method.post.rawValue
        default:
            return HTTP.Method.post.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchPosts,
             .fetchOnePost,
             .getSchoolList,
             .getJobList, .allGeneralList:
            return nil
        case .register(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .updatePersonalInfo(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .UpdateAboutYourSchool(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .UpdateAdditionalInfo(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .InsertSocialMediaLink(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .InsertDisabilityStatus(_ ,let creds):
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .login(_, let email, let password):
            let login = LoginCredentials(CNIC: email, Password: password)
            let jsonPost = try? JSONEncoder().encode(login)
            return jsonPost
        case .applyForSchool(let schoolID, let studentID),
             .getStudentAdmissions(let schoolID, let studentID):
            let creds = ApplySchool(SchoolId: schoolID, StudentId: studentID)
            let jsonPost = try? JSONEncoder().encode(creds)
            return jsonPost
        case .sendPost(_, let post):
            let jsonPost = try? JSONEncoder().encode(post)
            return jsonPost
        case .updateProfile(_, let user):
            let jsonPost = try? JSONEncoder().encode(user)
            return jsonPost
        case .uploadSchoolProfile(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updatePersonalInformation(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updateAboutYourSchool(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updateAdditionalInfo(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertSocialMediaLink(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteSocialMediaLink(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertSocialMultiMedia(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteSocialMultiMediaLink(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertDisabilityStatus(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteDisabilityStatus(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .applyForJob(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updateOrInsertJobSeekerDetail(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .getJobSeekerCertifications(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .getJobSeekerTechnicalSkills(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertJobSeekerTechnicalSkills(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertJobSeekerEducation(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertJobSeekerWorkExperience(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updateJobSeekerCertifications(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .uploadJobSeekerProfileImage(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .uploadJobSeekerCV(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .uploadDisabilityCertificate(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updatePersonalInformationJob(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteJobSeekerEducationSkills(let cred),
                .deleteJobSeekerWorkExperience(let cred),
                .deleteJobSeekerCertification(let cred),
                .deleteJobSeekerTechnicalSkills(let cred),
                .deleteJobSeekerAdditionalInfo(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertJobSeekerAdditionalInfo(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .getUser(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .studentAdmissionUpdate(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .uploadEmployerProfile(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .updateEmployerPersonalInformation(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertEmployerSocialMediaLink(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteEmployerSocialMediaLink(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertEmployerDisabilityStatus(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteEmployerDisabilityStatus(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .insertEmployerAccessibilityStatus(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        case .deleteEmployerAccessibilityStatus(let cred):
            let jsonPost = try? JSONEncoder().encode(cred)
            return jsonPost
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchPosts, .fetchOnePost:
            break
        case .sendPost, 
                .login,
                .register,
                .getSchoolList, .applyForSchool, .getStudentAdmissions,
                .updatePersonalInfo, .UpdateAboutYourSchool,
                .UpdateAdditionalInfo, .InsertSocialMediaLink,
                .InsertDisabilityStatus, .allGeneralList, .getJobList,
                .updateProfile,.uploadSchoolProfile, .updatePersonalInformation, .updateAboutYourSchool,.updateAdditionalInfo,
                .insertSocialMediaLink, .deleteSocialMediaLink, .insertSocialMultiMedia, .deleteSocialMultiMediaLink,
                .insertDisabilityStatus, .deleteDisabilityStatus, .applyForJob:
            self.setValue(
                HTTP.Headers.Value.applicationJson.rawValue,
                forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue
            )
        default:
            self.setValue(
                HTTP.Headers.Value.applicationJson.rawValue,
                forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue
            )
        }
    }
}
