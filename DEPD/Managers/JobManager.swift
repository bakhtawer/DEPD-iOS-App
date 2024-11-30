//
//  JobManager.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 30/11/2024.
//

final class JobManager {
    static let shared = JobManager()
    private let service = APIService()
    private init() {}
    
    
    func applyForJob(data: ApplyForJobCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.applyForJob(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func handelResponse(_ error: APIError?,
                        _ userResponse: ApiResponse<String>?,
                        completion: @escaping (Bool) -> Void) {
        if error != nil {
            completion(false)
            return }
        if let error = userResponse?.isError, error { SMM.shared.showError(title: "", message: userResponse?.errorMessage ?? "Something went Wrong");
            completion(false)
            return }
        completion(true)
    }
}

struct ApplyForJobCreds: Codable {
    let jobid: Int
    let statusid: Int
    let userid: Int
}

// UpdateOrInsertJobSeekerDetail
struct UpdateOrInsertJobSeekerDetailCreds: Codable {}
extension JobManager {
    func updateOrInsertJobSeekerDetail(data: UpdateOrInsertJobSeekerDetailCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.updateOrInsertJobSeekerDetail(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// GetJobSeekerCertifications
struct GetJobSeekerCertificationsCreds: Codable {}
extension JobManager {
    func getJobSeekerCertifications(data: GetJobSeekerCertificationsCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.getJobSeekerCertifications(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}


// GetJobSeekerTechnicalSkills
struct GetJobSeekerTechnicalSkillsCreds: Codable {}
extension JobManager {
    func getJobSeekerTechnicalSkills(data: GetJobSeekerTechnicalSkillsCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.getJobSeekerTechnicalSkills(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// InsertJobSeekerTechnicalSkills
struct InsertJobSeekerTechnicalSkillsCreds: Codable {
    let RelID: Int
    let SkillDescription: String
}
extension JobManager {
    func insertJobSeekerTechnicalSkills(data: InsertJobSeekerTechnicalSkillsCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertJobSeekerTechnicalSkills(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// InsertJobSeekerEducation
struct InsertJobSeekerEducationCreds: Codable {
    let Degree: String
    let Duration: String
    let Institution: String
    let RelID: Int
}
extension JobManager {
    func insertJobSeekerEducation(data: InsertJobSeekerEducationCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertJobSeekerEducation(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// DeleteJobSeekerTechnicalSkillsCreds
struct DeleteJobSeekerCreds: Codable {
    var Id: Int
    var RelId: Int
}
extension JobManager {
    func deleteJobSeekerEducationSkills(data: DeleteJobSeekerCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteJobSeekerEducationSkills(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func deleteJobSeekerWorkExperience(data: DeleteJobSeekerCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteJobSeekerWorkExperience(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func deleteJobSeekerTechnicalSkills(data: DeleteJobSeekerCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteJobSeekerTechnicalSkills(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func deleteJobSeekerCertification(data: DeleteJobSeekerCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteJobSeekerCertification(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
    
    func deleteJobSeekerAdditionalInfo(data: DeleteJobSeekerCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.deleteJobSeekerAdditionalInfo(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// InsertJobSeekerWorkExperience
struct InsertJobSeekerWorkExperienceCreds: Codable {
    let CompanyName: String
    let Duration: String
    let JobTitle: String
    let RelID: Int
}
extension JobManager {
    func insertJobSeekerWorkExperience(data: InsertJobSeekerWorkExperienceCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertJobSeekerWorkExperience(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// UpdateJobSeekerCertifications
struct UpdateJobSeekerCertificationsCreds: Codable {
    let CertificationName: String
    let Duration: String
    let Issuer: String
    let RelID: Int
}
extension JobManager {
    func updateJobSeekerCertifications(data: UpdateJobSeekerCertificationsCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.updateJobSeekerCertifications(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// UploadJobSeekerProfileImageCreds
struct UploadJobSeekerProfileImageCreds: Codable {
    let profileImageName: String
    let ProfileImageByteString: String
    let UserID: Int
}
extension JobManager {
    func uploadJobSeekerProfileImage(data: UploadJobSeekerProfileImageCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.uploadJobSeekerProfileImage(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// UploadJobSeekerCVCreds
struct UploadJobSeekerCVCreds: Codable {
    let CVFileUploadName: String
    let CVFileUploadByteString: String
    let UserID: Int
}
extension JobManager {
    func uploadJobSeekerCV(data: UploadJobSeekerCVCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.uploadJobSeekerCV(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}

// UploadDisabilityCertificateCreds
struct UploadDisabilityCertificateCreds: Codable {
    let DisabilityCertificateName: String
    let DisabilityCertificateByteString: String
    let UserID: Int
}
extension JobManager {
    func uploadDisabilityCertificate(data: UploadDisabilityCertificateCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.uploadDisabilityCertificate(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}


// UpdatePersonalInformationCreds
struct UpdatePersonalInformationJobCreds: Codable {
    var userID: Int
    var Address: String
    var DisabilityId: Int
    var EmailAddress: String
    var Gender: Int
    var oUser: oUser
    struct oUser: Codable {
        var FirstName: String
        var LastName: String
        var CNIC: String?
        var ContactNo: String
    }
}
extension JobManager {
    func updatePersonalInformationJob(data: UpdatePersonalInformationJobCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.updatePersonalInformationJob(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}


// InsertJobSeekerAdditionalInfo
struct InsertJobSeekerAdditionalInfoCreds: Codable {
    let language: String
    let RelID: Int
}
extension JobManager {
    func insertJobSeekerAdditionalInfo(data: InsertJobSeekerAdditionalInfoCreds, completion: @escaping (Bool) -> Void) {
        let request = Endpoint.insertJobSeekerAdditionalInfo(creds: data).request!
        service.makeRequest(with: request, respModel: ApiResponse<String>.self) { [weak self] userResponse, error in
            self?.handelResponse(error, userResponse) {status in completion(status)}
        }
    }
}
