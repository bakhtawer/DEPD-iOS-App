//
//  EmployerHomeViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 13/10/2024.
//

import UIKit
import SwiftUI


enum EmployerSection: CaseIterable {
   case employee
   case advertise
   case hiring
}

class EmployerHomeViewController: MVVMViewController<EmployerHomeViewModel> {
    
    @IBOutlet weak var mainIcon: UIView!
    @IBOutlet weak var mainIconImage: UIImageView!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolLocation: UILabel!
    @IBOutlet weak var schoolProfilePercentage: UILabel!
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tfSearchBar: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var dataSource: UICollectionViewDiffableDataSource<EmployerSection, EmployerHomeViewModelData>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var viewApplications: UIView!
    @IBOutlet weak var buttonViewApplications: UIButton!
    @IBOutlet weak var buttonEditYourProfile: UIButton!
    
    @IBOutlet weak var buttonFindEmployee: UILabel!
    @IBOutlet weak var buttonAdvertise: UILabel!
    @IBOutlet weak var buttonConfirmHiring: UILabel!
    
    
    private enum ScreenSelected{
        case employee
        case advertise
        case hiring
    }
    
    private var screenSelected = ScreenSelected.employee
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        setUpCollectionView()
        
        viewApplications.isHidden = true
        
        tfSearchBar.delegate = self
        viewModel.delegate = self
        
        viewModel.fetchAllJobs()
        
        buttonEdit.addTapGestureRecognizer {
//            DispatchQueue.main.async {[weak self] in
//                let storyboard = getStoryBoard(.main)
//                let view = storyboard.instantiateViewController(ofType: SchoolDetailsViewController.self)
////                view.selectedSchool = self?.viewModel.selectedSchool
//                openModuleOnNavigation(from: self, controller: view)
//            }
        }
        
        viewSearch.isHidden = true
        buttonFindEmployee.addTapGestureRecognizer {[weak self] in
            self?.screenSelected = .employee
            self?.viewSearch.isHidden = true
            self?.fetchedDetails()
        }
        buttonAdvertise.addTapGestureRecognizer {[weak self] in
            self?.screenSelected = .advertise
            self?.viewSearch.isHidden = true
            self?.fetchedDetails()
        }
        buttonConfirmHiring.addTapGestureRecognizer {[weak self] in
            self?.screenSelected = .hiring
            self?.viewSearch.isHidden = false
            self?.fetchedDetails()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
        
        collectionView.reloadData()
    }
    
    private func setView() {
        mainIcon.roundCorner(withRadis: mainIcon.viewHeight.half)
        mainIconImage.roundCorner(withRadis: mainIconImage.viewHeight.half)
        viewTopBG.applyShadow()
        
        schoolName.makeItTheme(.bold, 16, .textDark)
        schoolLocation.makeItTheme(.regular, 13, .textLightGray)
        schoolProfilePercentage.makeItTheme(.regular, 13, .appBlue)
        
        buttonFindEmployee.makeItTheme(.bold, 9, .appLight)
        buttonAdvertise.makeItTheme(.bold, 9, .appLight)
        buttonConfirmHiring.makeItTheme(.bold, 9, .appLight)
        
        buttonFindEmployee.text = "\("find_an_employee".localized())"
        buttonAdvertise.text = "\("advertise_vacancies".localized())"
        buttonConfirmHiring.text = "\("confirm_hiring".localized())"
        
        schoolName.text = USM.shared.getUserFullName()
    }
    
    private func setUpCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appBG
        
        collectionView.register(UINib(nibName: "CompanyJobCell", bundle: nil), forCellWithReuseIdentifier: CompanyJobCell.reuseIdentifier)
        
        collectionView.register(UINib(nibName: "InstituteStudentCell", bundle: nil), forCellWithReuseIdentifier: InstituteStudentCell.reuseIdentifier)
        
        collectionView.register(UINib(nibName: "CompanyAdvertiseJobCell", bundle: nil), forCellWithReuseIdentifier: CompanyAdvertiseJobCell.reuseIdentifier)
        
        createDataSource()
    }
}

extension EmployerHomeViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setTitle("welcom_to_employer_hub".localized())
        self.setMenuButton(.textDark).addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SettingViewController.self)
            openModulePopOver(controller: view)
        }
    }
}

extension EmployerHomeViewController: EmployerHomeVM {
    func showLoader() {
        DispatchQueue.main.async {[weak self] in
            self?.showLoadingIndicator()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {[weak self] in
            self?.hideLoadingIndicator()
        }
    }
    
    func fetchedDetails() {
        DispatchQueue.main.async {[weak self] in
            self?.reloadData()
        }
    }
}

extension EmployerHomeViewController { // Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch self.screenSelected {
            case .employee, .hiring:
                // Standard section with item height of 147
                return self.createInstituteSection()
            case .advertise:
                return self.createInstituteSection(itemHight: 244)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .leastNormalMagnitude
        config.scrollDirection = .vertical
        layout.configuration = config
        return layout
    }
}
extension EmployerHomeViewController { // Make Search Section
    func createInstituteSection(itemHight: CGFloat = 147) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(itemHight)
            )
          )
          item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(itemHight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}

extension EmployerHomeViewController {
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<EmployerSection,
                                                        EmployerHomeViewModelData>(collectionView: self.collectionView) { _, indexPath, app in
                                                            
                                                            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: app) else {
                                                                        return UICollectionViewCell()
                                                                    }
                                                            
                                                            switch section {
                                                            case .employee:
                                                                guard let cell = self.collectionView.dequeueReusableCell(
                                                                    withReuseIdentifier: InstituteStudentCell.reuseIdentifier,
                                                                    for: indexPath
                                                                ) as? InstituteStudentCell else {
                                                                    return UICollectionViewCell()
                                                                }
                                                                cell.configure(with: app)
                                                                return cell
                                                                
                                                            case .advertise:
                                                                guard let cell = self.collectionView.dequeueReusableCell(
                                                                    withReuseIdentifier: CompanyAdvertiseJobCell.reuseIdentifier,
                                                                    for: indexPath
                                                                ) as? CompanyAdvertiseJobCell else {
                                                                    return UICollectionViewCell()
                                                                }
                                                                cell.configure(with: app)
                                                                return cell
                                                            case .hiring:
                                                                guard let cell = self.collectionView.dequeueReusableCell(
                                                                    withReuseIdentifier: CompanyJobCell.reuseIdentifier,
                                                                    for: indexPath
                                                                ) as? CompanyJobCell else {
                                                                    return UICollectionViewCell()
                                                                }
                                                                cell.configure(with: app)
                                                                return cell
                                                            }
                                                        }
                                                            
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<EmployerSection, EmployerHomeViewModelData>()
        switch screenSelected {
        case .employee:
            snapshot.appendSections([.employee])
            snapshot.appendItems(viewModel.getEmployees(), toSection: .employee)
        case .advertise:
            snapshot.appendSections([.advertise])
            snapshot.appendItems(viewModel.getAdvertise(), toSection: .advertise)
        case .hiring:
            snapshot.appendSections([.hiring])
            snapshot.appendItems(viewModel.getJobs(), toSection: .hiring)
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}

extension EmployerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        DispatchQueue.main.async {[weak self] in
////            let storyboard = getStoryBoard(.main)
////            let view = storyboard.instantiateViewController(ofType: SchoolStudentDetailViewController.self)
////            view.selectedStudent = self?.viewModel.getJobs()[indexPath.row]
////            openModuleOnNavigation(from: self, controller: view)
//        }
        
        if indexPath.section == 0 {
            let userProfile = JobSeekerProfileModel(
                name: "Salman Ibrahim",
                location: "Punjab, Pakistan",
                email: "salman.ibrahim@gmail.com",
                cnic: "123-123456-9",
                contactNumber: "0322-12345678",
                education: [
                    Education(institution: "Islamic Public Institute", degree: "Diploma in Graphic Design", years: "2013-2015"),
                    Education(institution: "Karachi University", degree: "Bachelor's Degree", years: "2010-2012")
                ],
                technicalSkills: ["Graphics Designing", "MS Word", "MS Excel", "Illustrations"],
                certifications: [
                    Certification(institution: "Islamic Public Institute", title: "Diploma in Graphic Design", years: "2013-2015"),
                    Certification(institution: "Karachi University", title: "Bachelor's Degree", years: "2010-2012")
                ],
                languages: ["Sindhi", "English", "Urdu"],
                disabilityCertificate: "None",
                disabilityStatus: "None",
                profileImage: "https://example.com/path/to/profile-image.jpg"
            )
            
//            // Use the userProfile instance to initialize UserProfileView in your SwiftUI view hierarchy
//            let profileView = UserProfileView(userProfile: userProfile)
            
            // Create a UIHostingController with the UserProfileView
            let profileView = JobSeekerProfile(userProfile: userProfile)
            let hostingController = UIHostingController(rootView: profileView)
            
            // Present the UIHostingController
            openModuleOnNavigation(from: self, controller: hostingController)

        }
        
    }
}

extension EmployerHomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text
        let currentText = textField.text ?? ""
        // Calculate the text after the proposed edit
        if let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            // Call your view model's search function with the updated text
            viewModel.search(text: updatedText)
        }
        return true
    }
}
