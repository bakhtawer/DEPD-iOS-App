//
//  UpdateSchool.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 10/11/2024.
//

//{
//  "SchoolId": 1,
//  "oUser": {
//    "Id": 1,
//    "FirstName": "John",
//    "LastName": "Doe",
//    "CNIC": "XXXXX-XXXXXXX-X",
//    "ContactNo": "+XXXXXXX",
//    "EmailAddress": "example@school.com",
//    "Designation": "Principal"
//  },
//  "SchoolName": "Sample School",
//  "NTNNumber": "XXXX-XXXXXXX-X"
//}

struct UpdatePersonalInformation {
    var SchoolId: Int?
    var SchoolName: String?
    var NTNNumber: String?
    var oUser: oUser?
    struct oUser {
        var Id: Int?
        var FirstName: String?
        var LastName: String?
        var CNIC: String?
        var ContactNo: String?
        var EmailAddress: String?
        var Designation: String?
    }
}
