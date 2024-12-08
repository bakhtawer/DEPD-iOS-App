//
//  JobSeekerHomeViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/10/2024.
//

import UIKit

class JobSeekerHomeViewController: MVVMViewController<JobSeekerHomeViewModel>  {
    
    @IBOutlet weak var mainIcon: UIView!
    @IBOutlet weak var mainIconImage: UIImageView!
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolLocation: UILabel!
    @IBOutlet weak var schoolProfilePercentage: UILabel!
    
    @IBOutlet weak var tfSearchBar: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, CompanyModel>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var viewApplications: UIView!
    @IBOutlet weak var buttonViewApplications: UIButton!
    @IBOutlet weak var buttonEditYourProfile: UIButton!
    
    @IBOutlet weak var buttonTotalApplications: UILabel!
    @IBOutlet weak var buttonRegisteredusers: UILabel!
    @IBOutlet weak var buttonPendingStudents: UILabel!
    @IBOutlet weak var buttonRejectedStudents: UILabel!
    
    @IBOutlet weak var buttonNGO: UILabel!
    private var selectedFilterItems: [String : Any] = [:]
    private var filterItems: [FilterItem] = [
        FilterItem(type: .checkbox, title: "job_title".localized(), name: "job_title"),
        FilterItem(type: .checkbox, title: "private".localized(), name: "private"),
        FilterItem(type: .checkbox, title: "ngo_welfare".localized(), name: "ngo_welfare"),
        FilterItem(type: .dropdown, title: "district".localized(), name: "district", options: APPMetaDataHandler.shared.getDistrictsNames()),
        FilterItem(type: .multiSelect, title: "disability".localized(), name: "disability", options:APPMetaDataHandler.shared.getDisabilitiesNames())
    ]
    
    @IBOutlet weak var buttonFilter: DEPDButton!
    
    @IBOutlet weak var viewOldFilters: UIView!
    @IBOutlet weak var viewTotalJobs: UIView!
    @IBOutlet weak var labelTotalJobs: UILabel!
    
    
    @IBOutlet weak var labelNoRecord: UILabel!
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        setUpCollectionView()
        
        tfSearchBar.delegate = self
        viewModel.delegate = self
        viewModel.fetchAllJobs()
        
        buttonViewApplications.addTapGestureRecognizer {
            if APPMetaDataHandler.shared.userType == .JobSeekerGuest {
                Bootstrapper.showLoginAlert()
                return
            }
            
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: JobSeekerProfileDetailsController.self)
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        viewOldFilters.isHidden = true
        buttonFilter.addTapGestureRecognizer {
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
        
        self.schoolLocation.text = USM.shared.getUser().jobSeekerDetailInfo?.district
        self.schoolProfilePercentage.text = "\(USM.shared.getUser().percentage ?? 0)% \("profile_completed".localized())"
        guard let image = URL(string: USM.shared.getUser().jobSeekerDetailInfo?.profilePicture?.convertToHttps() ?? "") else { return }
        self.mainIconImage.contentMode = .scaleAspectFill
        self.mainIconImage.kf.setImage(with: image,
                                       placeholder: UIImage(named: "studentplacehoder"))
    }
    
    private func setView() {
        
        tfSearchBar.placeholder = "search_for_job".localized()
        tfSearchBar.applyShadow()
        
        mainIcon.roundCorner(withRadis: mainIcon.viewHeight.half)
        mainIconImage.roundCorner(withRadis: mainIconImage.viewHeight.half)
        
        buttonFilter.makeItTheme(text: "", .bold, 12, .appLight, .appBlue)  //"filter".localized()
        buttonFilter.makeButtonIconRight(imageNamed: "filter-icon")
        
        schoolName.makeItTheme(.bold, 20, .textDark)
        schoolLocation.makeItTheme(.regular, 16, .textLightGray)
        schoolProfilePercentage.makeItTheme(.regular, 16, .appBlue)
        
        buttonTotalApplications.makeItTheme(.bold, 9, .appLight, .center)
        buttonRegisteredusers.makeItTheme(.bold, 9, .appLight, .center)
        buttonPendingStudents.makeItTheme(.bold, 9, .appLight, .center)
        buttonRejectedStudents.makeItTheme(.bold, 9, .appLight, .center)
        buttonNGO.makeItTheme(.bold, 9, .appLight)
        
        labelTotalJobs.makeItTheme(.bold, 12, .textDark)
        labelTotalJobs.text = "\("total_jobs".localized()) \(viewModel.getCount())"
        viewTotalJobs.roundCorner(withRadis: viewTotalJobs.viewHeight.half)
        viewTotalJobs.setBorderColor(.appBlue, 1)
        
        buttonTotalApplications.text = "\("total_jobs".localized()) \(viewModel.getCount())"
        buttonRegisteredusers.text = "\("district".localized())"
        buttonPendingStudents.text = "\("disablity".localized())"
        buttonRejectedStudents.text = "\("private".localized())"
        buttonNGO.text = "\("ngo_welfare".localized())"
        
        buttonViewApplications.setTitle("\("edit_profile".localized())", for: .normal)
        buttonEditYourProfile.setTitle("\("my_applications".localized())", for: .normal)
        buttonViewApplications.makeItThemePrimary(14)
        buttonEditYourProfile.makeItThemeWhitePrimary(14)
        
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
        
        collectionView.register(UINib(nibName: "JobSeekerCompanyCell", bundle: nil), forCellWithReuseIdentifier: JobSeekerCompanyCell.reuseIdentifier)
        
        // Update the semantic content attribute based on the selected language
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            collectionView.semanticContentAttribute = .forceRightToLeft
        } else {
            collectionView.semanticContentAttribute = .forceLeftToRight
        }
        
        createDataSource()
    }
}

extension JobSeekerHomeViewController {
    func setupNavigation() {
        self.setTitle("inclusive_career_hub".localized())
        self.setNavBarColor(.appBG)
        self.setMenuButton(.textDark).addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SettingViewController.self)
            openModulePopOver(controller: view)
        }
    }
}

extension JobSeekerHomeViewController: JobSeekerVM {
    func fetchedJobs() {
        DispatchQueue.main.async {[weak self] in
            self?.buttonTotalApplications.text = "\("total_applications".localized()) \(self?.viewModel.getCount() ?? 0)"
            self?.reloadData()
        }
    }
    
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
}

extension JobSeekerHomeViewController { // Create Compositional Layout
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createInstituteSection()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = .leastNormalMagnitude
        config.scrollDirection = .vertical
        layout.configuration = config
        return layout
    }
}
extension JobSeekerHomeViewController { // Make Search Section
    func createInstituteSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(210)
            )
          )
          item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(210))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}

extension JobSeekerHomeViewController {
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<PoitsSection,
                                                        CompanyModel>(collectionView: self.collectionView) { _, indexPath, app in
                                                            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: JobSeekerCompanyCell.reuseIdentifier, for: indexPath) as? JobSeekerCompanyCell
                                                            else {
                                                                return UICollectionViewCell()
                                                            }
                cell.configure(with: app)
            return cell
        }
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PoitsSection, CompanyModel>()
        snapshot.appendSections([.all])
        let data = viewModel.getJobs()
        snapshot.appendItems(data, toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: false)
        labelNoRecord.isHidden = !data.isEmpty
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}

extension JobSeekerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if APPMetaDataHandler.shared.userType == .JobSeekerGuest {
            Bootstrapper.showLoginAlert()
            return
        }
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: JobSeekerDetailViewController.self)
            view.dataJob = self?.viewModel.getJobs()[indexPath.row]
            openModuleOnNavigation(from: self, controller: view)
        }
    }
}

extension JobSeekerHomeViewController: UITextFieldDelegate {
    
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

extension JobSeekerHomeViewController: FilterViewControllerDelegate {
    func didApplyFilters(selectedOptions: [String : Any]) {
        selectedFilterItems = selectedOptions
        viewModel.setAppliedFilters(filters: selectedOptions)
    }
}
