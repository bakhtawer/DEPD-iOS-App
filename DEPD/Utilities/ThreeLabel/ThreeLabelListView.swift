//
//  ThreeLabelListView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/11/2024.
//

import UIKit

class ThreeLabelListView: UIView {

    private let stackView = UIStackView()
    
    enum ScreenType {
        case EducationInfo
        case WorkExperience
        case TechnicalSkill
        case AdditionalInfo
        case Certification
    }
    
    var jobSeekerEducationInfo: [JobSeekerEducation] = [] {
        didSet {
            configureStackView(.EducationInfo)
        }
    }
    var jobSeekerWorkExperience: [JobSeekerWorkExperience] = [] {
        didSet {
            configureStackView(.WorkExperience)
        }
    }
    var jobSeekerTechnicalSkill: [JobSeekerTechnicalSkill] = [] {
        didSet {
            configureStackView(.TechnicalSkill)
        }
    }
    var jobSeekerAdditionalInfo: [JobSeekerAdditionalInfo] = [] {
        didSet {
            configureStackView(.AdditionalInfo)
        }
    }
    var jobSeekerCertification: [JobSeekerCertification] = [] {
        didSet {
            configureStackView(.Certification)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0 // Adjust spacing if needed
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureStackView(_ type: ScreenType) {
        // Remove old views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch type {
        case .EducationInfo:
            makeViewForEducationInfo()
        case .WorkExperience:
            makeViewForWorkExperience()
        case .TechnicalSkill:
            makeViewForTechnicalSkill()
        case .AdditionalInfo:
            makeViewForAdditionalInfo()
        case .Certification:
            makeViewForCertification()
        }
    }
    
    var onDeleteToggle: ((Int) -> Void)?
    
    private func makeViewForEducationInfo() {
        for (index, item) in jobSeekerEducationInfo.enumerated() {
            let view = ThreeLableView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.populateWith(index: index,
                              id: item.id ?? -1,
                              stringOne: item.institution,
                              stringTwo: item.degree,
                              stringThree: item.duration)
            view.onDeleteToggle = {[weak self] id in
                self?.onDeleteToggle?(id)
            }
            if index == jobSeekerEducationInfo.count - 1 {
                view.viewLine.isHidden = true
            }
            stackView.addArrangedSubview(view)
        }
    }
    private func makeViewForWorkExperience() {
        for (index, item) in jobSeekerWorkExperience.enumerated() {
            let view = ThreeLableView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.populateWith(index: index,
                              id: item.id ?? -1,
                              stringOne: item.companyName,
                              stringTwo: item.jobTitle,
                              stringThree: item.duration)
            view.onDeleteToggle = {[weak self] id in
                self?.onDeleteToggle?(id)
            }
            
            if index == jobSeekerWorkExperience.count - 1 {
                view.viewLine.isHidden = true
            }
            stackView.addArrangedSubview(view)
        }
    }
    private func makeViewForTechnicalSkill() {
        for (index, item) in jobSeekerTechnicalSkill.enumerated() {
            let view = ThreeLableView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.populateWith(index: index,
                              id: item.id ?? -1,
                              stringOne: item.skillDescription)
            view.onDeleteToggle = {[weak self] id in
                self?.onDeleteToggle?(id)
            }
            if index == jobSeekerTechnicalSkill.count - 1 {
                view.viewLine.isHidden = true
            }
            stackView.addArrangedSubview(view)
        }
    }
    private func makeViewForAdditionalInfo() {
        for (index, item) in jobSeekerAdditionalInfo.enumerated() {
            let view = ThreeLableView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.populateWith(index: index,
                              id: item.id ?? -1,
                              stringOne: item.name)
            view.onDeleteToggle = {[weak self] id in
                self?.onDeleteToggle?(id)
            }
            if index == jobSeekerAdditionalInfo.count - 1 {
                view.viewLine.isHidden = true
            }
            stackView.addArrangedSubview(view)
        }
    }
    private func makeViewForCertification() {
        for (index, item) in jobSeekerCertification.enumerated() {
            let view = ThreeLableView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.populateWith(index: index,
                              id: item.id ?? -1,
                              stringOne: item.issuer,
                              stringTwo: item.certificationName,
                              stringThree: item.duration)
            view.onDeleteToggle = {[weak self] id in
                self?.onDeleteToggle?(id)
            }
            if index == jobSeekerCertification.count - 1 {
                view.viewLine.isHidden = true
            }
            stackView.addArrangedSubview(view)
        }
    }
}

