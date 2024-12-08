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
    
    @IBOutlet weak var viewClickHired: UIView!
    @IBOutlet weak var labelClickHired: UILabel!
    
    @IBOutlet weak var labelTotalApplications: UILabel!
    private enum ScreenSelected{
        case employee
        case advertise
        case hiring
    }
    
    private var screenSelected = ScreenSelected.employee
    
    @IBOutlet weak var labelNoRecord: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        setUpCollectionView()
        
        tfSearchBar.delegate = self
        viewModel.delegate = self
        
        viewModel.fetchAllJobs()
        
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
        
        buttonViewApplications.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: EmployerProfileDetailsController.self)
                openModuleOnNavigation(from: self, controller: view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
        
        collectionView.setNeedsDisplay()
        collectionView.reloadData()
    }
    
    private func setView() {
        mainIcon.roundCorner(withRadis: mainIcon.viewHeight.half)
        mainIconImage.roundCorner(withRadis: mainIconImage.viewHeight.half)
//        viewTopBG.backgroundColor = .appLight
//        viewTopBG.applyShadow()
        
        schoolName.makeItTheme(.bold, 16, .textDark, .center)
        schoolLocation.makeItTheme(.regular, 13, .textLightGray, .center)
        schoolProfilePercentage.makeItTheme(.regular, 13, .appBlue, .center)
        
        buttonFindEmployee.makeItTheme(.bold, 9, .textDark, .center)
        buttonAdvertise.makeItTheme(.bold, 9, .textDark, .center)
        buttonConfirmHiring.makeItTheme(.bold, 9, .textDark, .center)
        buttonFindEmployee.backgroundColor = .appBGDark
        buttonAdvertise.backgroundColor = .appBGDark
        buttonConfirmHiring.backgroundColor = .appBGDark
        buttonFindEmployee.roundCorner(withRadis: 4)
        buttonAdvertise.roundCorner(withRadis: 4)
        buttonConfirmHiring.roundCorner(withRadis: 4)
        
        buttonFindEmployee.text = "\("all_application".localized())"
        buttonConfirmHiring.text = "\("find_an_employee".localized())"
        buttonAdvertise.text = "\("advertise_vacancies".localized())"
        
        schoolProfilePercentage.text = "\(USM.shared.getUser().percentage ?? 0)% \("profile_completed".localized())"
        
        buttonViewApplications.setTitle("\("edit_profile".localized())", for: .normal)
        buttonEditYourProfile.setTitle("\("my_applications".localized())", for: .normal)
        buttonViewApplications.makeItThemePrimary(14)
        buttonEditYourProfile.makeItThemeWhitePrimary(14)
        
        labelClickHired.makeItTheme(.bold, 12, .textDark)
        labelClickHired.text = "  \("check_hired".localized())  "
        viewClickHired.roundCorner(withRadis: viewClickHired.viewHeight.half)
        viewClickHired.setBorderColor(.appBlue, 1)
        
        labelTotalApplications.makeItTheme(.regular, 12, .textDark)
        labelTotalApplications.text = "10 Applications Available"
        
        
        labelNoRecord.text = "no_record_found".localized()
        labelNoRecord.makeItTheme(.regular, 16, .textLightGray)
        
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
        
        // Update the semantic content attribute based on the selected language
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            collectionView.semanticContentAttribute = .forceRightToLeft
        } else {
            collectionView.semanticContentAttribute = .forceLeftToRight
        }
        
        
        createDataSource()
    }
}

extension EmployerHomeViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.setTitle("welcom_to_employer_hub".localized())
        self.setNavBarColor(.appBG)
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
                return self.createInstituteSection(itemHight: 204)
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
                                                                cell.delegateEmployer = self
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
            let data = viewModel.getEmployees()
            snapshot.appendSections([.employee])
            snapshot.appendItems(data, toSection: .employee)
            labelNoRecord.isHidden = !data.isEmpty
        case .advertise:
            snapshot.appendSections([.advertise])
            let data = viewModel.getEmployees()
            snapshot.appendItems(data, toSection: .advertise)
            labelNoRecord.isHidden = !data.isEmpty
        case .hiring:
            snapshot.appendSections([.hiring])
            let data = viewModel.getJobs()
            snapshot.appendItems(data, toSection: .hiring)
            labelNoRecord.isHidden = !data.isEmpty
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}

extension EmployerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
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
extension EmployerHomeViewController: EmployerPortalCellProtocol {
    func viewProfile(id: Int) {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: JobSeekerProfileDetailsController.self)
//            view.selectedStudent = id
            openModuleOnNavigation(from: self, controller: view)
        }
    }
    
    func acceptAdmission(id: Int) {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
            view.type = .acceptJobApplication
            openModuleOnNavigation(from: self, controller: view)
        }
    }
    
    func rejectAdmission(id: Int) {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
            view.type = .rejectJobApplication
            openModuleOnNavigation(from: self, controller: view)
        }
    }
}
