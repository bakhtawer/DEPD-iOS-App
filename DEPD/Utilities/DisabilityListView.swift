//
//  DisabilityListView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 11/11/2024.
//

import UIKit

class DisabilityListView: UIView {
    
    enum ScreenType {
        case Disabilities
        case TechnicalSkill
        case allListData
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    var disabilities: [String] = [] {
        didSet {
            configureStackView(.Disabilities)
        }
    }
    
    var jobSeekerTechnicalSkill: [JobSeekerTechnicalSkill] = [] {
        didSet {
            configureStackView(.TechnicalSkill)
        }
    }
    
    var allListData: [AllListData] = [] {
        didSet {
            configureStackView(.allListData)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        setupStackView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .horizontal // For horizontal scrolling
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    // Configure stack view with image views from URLs
    fileprivate func setView(_ index: Int, _ name: String) {
        let stackIvew = UIStackView()
        stackIvew.axis = .horizontal
        stackIvew.backgroundColor = .appOrange
        stackIvew.roundCorner(withRadis: 6)
        let viewContianer = UIView()
        viewContianer.backgroundColor = .clear
        let imageView = createImageView()
        imageView.image = UIImage(systemName: "trash.fill")
        imageView.tintColor = .appLight
        imageView.tag = index
        imageView.translatesAutoresizingMaskIntoConstraints = true
        viewContianer.translatesAutoresizingMaskIntoConstraints = true
        viewContianer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewContianer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        viewContianer.addSubview(imageView)
        stackIvew.addArrangedSubview(viewContianer)
        let label = createLabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = name
        stackIvew.addArrangedSubview(label)
        let gapview  = UIView()
        gapview.widthAnchor.constraint(equalToConstant: 8).isActive = true
        stackIvew.addArrangedSubview(gapview)
        stackIvew.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackIvew.addTapGestureRecognizer {[weak self] in
            self?.onToggle?(index)
        }
        stackView.addArrangedSubview(stackIvew)
    }
    
    private func configureStackView(_ type: ScreenType) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch type {
        case .Disabilities:
            for (index, disability) in disabilities.enumerated() {
                setView(index, disability)
            }
        case .TechnicalSkill:
            for (index, techSkill) in jobSeekerTechnicalSkill.enumerated() {
                setView(index, techSkill.skillDescription ?? "")
            }
        case .allListData:
            for (index, data) in allListData.enumerated() {
                setView(index, data.name ?? "")
            }
        }
    
    }
    
    // Closure to notify about changes
    var onToggle: ((Int) -> Void)?

    
    // Create and configure an image view
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 6, y: 6, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
    
    // Create and configure an image view
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.makeItTheme(.bold, 12, .appLight)
        return label
    }
}
