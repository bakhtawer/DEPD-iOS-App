//
//  SchoolHomeViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 14/09/2024.
//

import UIKit


class SchoolHomeViewController: MVVMViewController<SchoolHomeViewModel>  {
    
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
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: SchoolDetailsViewController.self)
                view.selectedSchool = self?.viewModel.selectedSchool
                openModuleOnNavigation(from: self, controller: view)
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
        
        collectionView.register(UINib(nibName: "InstituteStudentCell", bundle: nil), forCellWithReuseIdentifier: InstituteStudentCell.reuseIdentifier)
        
        createDataSource()
    }
}

extension SchoolHomeViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        
        self.setMenuButton(.textDark).addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SettingViewController.self)
            openModulePopOver(controller: view)
        }
    }
}

extension SchoolHomeViewController: SchoolHomeVM {
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

extension SchoolHomeViewController { // Create Compositional Layout
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
extension SchoolHomeViewController { // Make Search Section
    func createInstituteSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(147)
            )
          )
          item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(140))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}

extension SchoolHomeViewController {
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<PoitsSection,
                                                        InstituteHomeModel>(collectionView: self.collectionView) { _, indexPath, app in
                                                            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: InstituteStudentCell.reuseIdentifier, for: indexPath) as? InstituteStudentCell
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

extension SchoolHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SchoolStudentDetailViewController.self)
            view.selectedStudent = self?.viewModel.getInstitutes()[indexPath.row]
            openModuleOnNavigation(from: self, controller: view)
        }
    }
}

extension SchoolHomeViewController: UITextFieldDelegate {
    
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
