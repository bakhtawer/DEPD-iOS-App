//
//  JobSeekerProfile.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 31/10/2024.
//

import SwiftUI
import Kingfisher

struct JobSeekerProfile: View {
    let userProfile: JobSeekerProfileModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Header with Profile Image and User Info
                HStack {
//                    KFImage(URL(string: userProfile.profileImage))
//                        .placeholder {
//                            // Placeholder image while loading
//                            Image(systemName: "studentplacehoder")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 60, height: 60)
//                                .clipShape(Circle())
//                                .foregroundColor(.gray)
//                        }
                    Image(systemName: "studentplacehoder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
//                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                
                    VStack(alignment: .leading) {
                        Text(userProfile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(userProfile.location)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "bell")
                        .font(.title)
                        .foregroundColor(.gray) // Set to match your design
                }
                
                Divider()
                
                // Personal Information
                Group {
                    HStack {
                        
                        ThemedText(text: "Personal Information", fontType: .bold, size: 16)
                        Spacer()
                        Image(systemName: "plus.circle")
                    }
                    ThemedText(text: userProfile.name, fontType: .regular, size: 14)
                    ThemedText(text: userProfile.email, fontType: .regular, size: 14)
                    ThemedText(text: "CNIC: \(userProfile.cnic)", fontType: .regular, size: 14)
                    ThemedText(text: "Contact Number: \(userProfile.contactNumber)", fontType: .regular, size: 14)
                }
                
                Divider()
                
                // Education Section
                Group {
                    HStack {
                        ThemedText(text: "Education", fontType: .bold, size: 16)
                        Spacer()
                        Image(systemName: "plus.circle")
                    }
                    
                    ForEach(userProfile.education, id: \.institution) { education in
                        VStack(alignment: .leading) {
                            ThemedText(text: education.institution, fontType: .regular, size: 14)
                            ThemedText(text: "\(education.degree) \(education.years)", fontType: .regular, size: 14)
                        }
                    }
                }
                
                Divider()
                
                // Technical Skills Section
                Group {
                    HStack {
                        ThemedText(text: "Technical Skills", fontType: .bold, size: 16)
                        Spacer()
                        Image(systemName: "plus.circle")
                    }
                    
                    ForEach(userProfile.technicalSkills, id: \.self) { skill in
                        ThemedText(text: skill, fontType: .regular, size: 14)
                    }
                }
                
                Divider()
                
                // Certifications Section
                Group {
                    HStack {
                        ThemedText(text: "Certification", fontType: .bold, size: 16)
                        Spacer()
                        Image(systemName: "plus.circle")
                    }
                    
                    ForEach(userProfile.certifications, id: \.institution) { certification in
                        VStack(alignment: .leading) {
                            ThemedText(text: certification.institution, fontType: .regular, size: 14)
                            ThemedText(text: "\(certification.title) \(certification.years)", fontType: .regular, size: 14)
                        }
                    }
                }
                
                Divider()
                
                // Additional Information Section
                Group {
                    HStack {
                        ThemedText(text: "Additional Information", fontType: .bold, size: 16)
                        Spacer()
                        Image(systemName: "plus.circle")
                    }
                    
                    ThemedText(text: "Language: \(userProfile.languages.joined(separator: ", "))", fontType: .regular, size: 14)
                    ThemedText(text: "Disability Certificate: \(userProfile.disabilityCertificate)", fontType: .regular, size: 14)
                    ThemedText(text: "Disability Status: \(userProfile.disabilityStatus)", fontType: .regular, size: 14)
                }
            }
            .padding()
            .background(Color.appBG) // Set background color here
        }
        .background(Color.appBG) // Optional, for full screen consistency
        .navigationTitle("JobSeeker Profile")
    }
}
