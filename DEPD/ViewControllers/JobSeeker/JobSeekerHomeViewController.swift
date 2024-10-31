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
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolLocation: UILabel!
    @IBOutlet weak var schoolProfilePercentage: UILabel!
    
    @IBOutlet weak var tfSearchBar: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, InstituteHomeModel>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var viewApplications: UIView!
    @IBOutlet weak var buttonViewApplications: UIButton!
    @IBOutlet weak var buttonEditYourProfile: UIButton!
    
    @IBOutlet weak var buttonTotalApplications: UILabel!
    @IBOutlet weak var buttonRegisteredusers: UILabel!
    @IBOutlet weak var buttonPendingStudents: UILabel!
    @IBOutlet weak var buttonRejectedStudents: UILabel!
    
    private var selectedFilterItems: [String : Any] = [:]
    
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
        viewModel.fetchStudents()
        
        buttonEdit.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                
                let filterItems = [
                    FilterItem(type: .checkbox, title: "Registered User"),
                    FilterItem(type: .checkbox, title: "Pending User"),
                    FilterItem(type: .dropdown, title: "District", options: APPMetaDataHandler.shared.getDistrictsNames()),
                    FilterItem(type: .multiSelect, title: "Disability", options:APPMetaDataHandler.shared.getDisabilitiesNames())
                ]

                let filterVC = FilterViewController()
                filterVC.filterItems = filterItems
                filterVC.selectedOptions = self?.selectedFilterItems ?? [:]
                filterVC.delegate = self
                openModulePopOver(controller: filterVC)
                

                
//                let storyboard = getStoryBoard(.main)
//                let view = storyboard.instantiateViewController(ofType: SchoolDetailsViewController.self)
//                view.selectedSchool = self?.viewModel.selectedSchool
//                openModuleOnNavigation(from: self, controller: view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
        
        collectionView.reloadData()
    }
    
    private func setView() {
        
        tfSearchBar.placeholder  = "Search for Job"
        
        mainIcon.roundCorner(withRadis: mainIcon.viewHeight.half)
        mainIconImage.roundCorner(withRadis: mainIconImage.viewHeight.half)
        viewTopBG.applyShadow()
        
        schoolName.makeItTheme(.bold, 16, .textDark)
        schoolLocation.makeItTheme(.regular, 13, .textLightGray)
        schoolProfilePercentage.makeItTheme(.regular, 13, .appBlue)
        
        buttonTotalApplications.makeItTheme(.bold, 9, .appLight)
        buttonRegisteredusers.makeItTheme(.bold, 9, .appLight)
        buttonPendingStudents.makeItTheme(.bold, 9, .appLight)
        buttonRejectedStudents.makeItTheme(.bold, 9, .appLight)
        
        buttonTotalApplications.text = "\("total_applications".localized()) \(viewModel.getCount())"
        buttonRegisteredusers.text = "\("registered_students".localized())"
        buttonPendingStudents.text = "\("pending_students".localized())"
        buttonRejectedStudents.text = "\("rejected_students".localized())"
        
        schoolName.text = USM.shared.getUserFullName()
    }
    
    private func setUpCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appBG
        
        collectionView.register(UINib(nibName: "JobSeekerCompanyCell", bundle: nil), forCellWithReuseIdentifier: JobSeekerCompanyCell.reuseIdentifier)
        
        createDataSource()
    }
}

extension JobSeekerHomeViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        
        self.setMenuButton(.textDark).addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SettingViewController.self)
            openModulePopOver(controller: view)
        }
    }
}

extension JobSeekerHomeViewController: SchoolHomeVM {
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
    
    func fetchedInstitutes() {
        DispatchQueue.main.async {[weak self] in
            self?.buttonTotalApplications.text = "\("total_applications".localized()) \(self?.viewModel.getCount() ?? 0)"
            self?.reloadData()
        }
    }
    func fetchedInstituteDetails() {
        DispatchQueue.main.async {[weak self] in
            self?.schoolLocation.text = self?.viewModel.selectedSchool?.Location
            self?.schoolProfilePercentage.text = "0% \("profile_completed".localized())"
            guard let image = URL(string: self?.viewModel.selectedSchool?.ImageURL?.convertToHttps() ?? "") else { return }
            self?.mainIconImage.contentMode = .scaleAspectFill
            self?.mainIconImage.kf.setImage(with: image,
                                    placeholder: UIImage(named: "studentplacehoder"))
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
                                                        InstituteHomeModel>(collectionView: self.collectionView) { _, indexPath, app in
                                                            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: JobSeekerCompanyCell.reuseIdentifier, for: indexPath) as? JobSeekerCompanyCell
                                                            else {
                                                                return UICollectionViewCell()
                                                            }
                cell.configure(with: app)
            return cell
        }
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PoitsSection, InstituteHomeModel>()
        snapshot.appendSections([.all])
        snapshot.appendItems(viewModel.getInstitutes(), toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}

extension JobSeekerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {[weak self] in
//            let storyboard = getStoryBoard(.main)
//            let view = storyboard.instantiateViewController(ofType: SchoolStudentDetailViewController.self)
//            view.selectedStudent = self?.viewModel.getInstitutes()[indexPath.row]
//            openModuleOnNavigation(from: self, controller: view)
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
    }
}

