//
//  EmployerListViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 29/12/2024.
//

import UIKit
import SwiftUI

enum EmployerListScreenType {
    case totalApplications
    case hiredPerson
    case findEmployee
    case confirmHiring
    case advertiseVacancy
}

class EmployerListViewController: MVVMViewController<EmployerHomeViewModel> {
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tfSearchBar: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var dataSource: UICollectionViewDiffableDataSource<EmployerSection, EmployerHomeViewModelData>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var buttonFindEmployee: UILabel!
    @IBOutlet weak var buttonAdvertise: UILabel!
    @IBOutlet weak var buttonConfirmHiring: UILabel!
    
    @IBOutlet weak var labelTotalApplications: UILabel!
    
    private enum ScreenSelected {
        case jobApplications
        case advertise
        case employees
    }
    
    private var screenSelected = ScreenSelected.jobApplications
    
    var screenType: EmployerListScreenType = .totalApplications
    
    @IBOutlet weak var labelNoRecord: UILabel!
    
    @IBOutlet weak var viewTopButtons: UIView!
    
    @IBOutlet weak var viewTotlaCounts: UIView!
    private var peopleApplications = ""
    
    
    private var selectedFilterItems: [String : Any] = [:]
    private var filterItems: [FilterItem] = [
        FilterItem(type: .checkbox, title: "job_title".localized(), name: "job_title"),
        FilterItem(type: .checkbox, title: "private".localized(), name: "private"),
        FilterItem(type: .checkbox, title: "ngo_welfare".localized(), name: "ngo_welfare"),
        FilterItem(type: .dropdown, title: "district".localized(), name: "district", options: APPMetaDataHandler.shared.getDistrictsNames()),
        FilterItem(type: .multiSelect, title: "disability".localized(), name: "disability", options:APPMetaDataHandler.shared.getDisabilitiesNames())
    ]
    
    @IBOutlet weak var buttonFIlter: DEPDButton!
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
        tfSearchBar.placeholder = "search".localized()
        viewTopButtons.isHidden = true
        viewSearch.isHidden = true
        viewTotlaCounts.isHidden = true
        buttonFIlter.isHidden  = true
        
        
        switch screenType {
        case .totalApplications:
            screenSelected = .jobApplications
            viewSearch.isHidden = false
            viewTopButtons.isHidden = false
            viewTotlaCounts.isHidden = false
            peopleApplications = "applications_available".localized()
            viewModel.getTotaljobApplications()
        case .hiredPerson:
            screenSelected = .jobApplications
            viewSearch.isHidden = false
            viewTotlaCounts.isHidden = false
            peopleApplications = "people_hired".localized()
            viewModel.getHiredPerson()
        case .findEmployee:
            screenSelected = .employees
            viewSearch.isHidden = false
            buttonFIlter.isHidden = false
            viewModel.getJobSeekerFilter(data: JobSeekerFilterCreds())
        case .confirmHiring:
            break
        case .advertiseVacancy:
            screenSelected = .advertise
            viewModel.getVacancy()
        }
        
        buttonFindEmployee.addTapGestureRecognizer {[weak self] in
            self?.viewModel.selectedStatus(status: 1)
        }
        buttonConfirmHiring.addTapGestureRecognizer {[weak self] in
            self?.viewModel.selectedStatus(status: 2)
        }
        buttonAdvertise.addTapGestureRecognizer {[weak self] in
            self?.viewModel.selectedStatus(status: 3)
        }
        
        buttonFIlter.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let filterVC = FilterViewController()
                filterVC.filterItems = self?.filterItems ?? []
                filterVC.selectedOptions = self?.selectedFilterItems ?? [:]
                filterVC.delegate = self
                openModulePopOver(controller: filterVC)
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
        buttonFindEmployee.makeItTheme(.bold, 9, .textDark, .center)
        buttonAdvertise.makeItTheme(.bold, 9, .textDark, .center)
        buttonConfirmHiring.makeItTheme(.bold, 9, .textDark, .center)
        buttonFindEmployee.backgroundColor = .appBGDark
        buttonAdvertise.backgroundColor = .appBGDark
        buttonConfirmHiring.backgroundColor = .appBGDark
        buttonFindEmployee.roundCorner(withRadis: 4)
        buttonAdvertise.roundCorner(withRadis: 4)
        buttonConfirmHiring.roundCorner(withRadis: 4)
        
        buttonFindEmployee.text = "\("pending".localized())"
        buttonConfirmHiring.text = "\("accepted".localized())"
        buttonAdvertise.text = "\("rejected".localized())"
        
        labelTotalApplications.makeItTheme(.regular, 12, .textDark)
        
        labelNoRecord.text = "no_record_found".localized()
        labelNoRecord.makeItTheme(.regular, 16, .textLightGray)
        
        buttonFIlter.makeItTheme(text: "", .bold, 12, .appLight, .appBlue)  //"filter".localized()
        buttonFIlter.makeButtonIconRight(imageNamed: "filter-icon")
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

extension EmployerListViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        switch screenType {
        case .totalApplications:
            self.setTitle("total_applications".localized())
        case .hiredPerson:
            self.setTitle("hired_person".localized())
        case .findEmployee:
            self.setTitle("find_employee".localized())
        case .confirmHiring:
            self.setTitle("confirm_hiring".localized())
        case .advertiseVacancy:
            self.setTitle("advertise_vacancy".localized())
        }
        self.setNavBarColor(.appBG)
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension EmployerListViewController: EmployerHomeVM {
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

extension EmployerListViewController { // Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch self.screenSelected {
            case .jobApplications:
                // Standard section with item height of 147
                return self.createInstituteSection(itemHight: 204)
            case .employees:
                // Standard section with item height of 147
                return self.createInstituteSection(itemHight: 147)
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
extension EmployerListViewController { // Make Search Section
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

extension EmployerListViewController {
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
                                                                    withReuseIdentifier: InstituteStudentCell.reuseIdentifier,
                                                                    for: indexPath
                                                                ) as? InstituteStudentCell else {
                                                                    return UICollectionViewCell()
                                                                }
                                                                cell.configure(with: app, hideButtons: true)
                                                                return cell
                                                            }
                                                        }
                                                            
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<EmployerSection, EmployerHomeViewModelData>()
        switch screenSelected {
        case .jobApplications:
            let data = viewModel.getJobApplications()
            snapshot.appendSections([.employee])
            snapshot.appendItems(data, toSection: .employee)
            labelNoRecord.isHidden = !data.isEmpty
            labelTotalApplications.text = "\(data.count) \(peopleApplications)"
        case .advertise:
            snapshot.appendSections([.advertise])
            let data = viewModel.getAdvertise()
            snapshot.appendItems(data, toSection: .advertise)
            labelNoRecord.isHidden = !data.isEmpty
        case .employees:
            let data = viewModel.getFindEmployee()
            snapshot.appendSections([.hiring])
            snapshot.appendItems(data, toSection: .hiring)
            labelNoRecord.isHidden = !data.isEmpty
        }
        
        dataSource?.apply(snapshot, animatingDifferences: false)
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}

extension EmployerListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension EmployerListViewController: UITextFieldDelegate {
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
extension EmployerListViewController: EmployerPortalCellProtocol {
    func viewProfile(id: Int) {
        DispatchQueue.main.async {[weak self] in
            guard let index = self?.viewModel.getJobApplications().firstIndex(where:  {$0.jobApplications?.Id == id})
            else { return }
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: ApplicantProfileViewController.self)
            view.selectedJobEmployee = self?.viewModel.getJobApplications()[index].jobApplications
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

extension EmployerListViewController: FilterViewControllerDelegate {
    func didApplyFilters(selectedOptions: [String : Any]) {
        selectedFilterItems = selectedOptions
        viewModel.setAppliedFilters(filters: selectedOptions)
    }
}
