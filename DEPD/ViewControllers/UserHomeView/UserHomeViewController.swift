//
//  UserHomeViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 26/05/2024.
//

import UIKit

class UserHomeViewController: MVVMViewController<UserHomeViewModel> {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    var dataSource: UICollectionViewDiffableDataSource<PoitsSection, InstituteModel>?
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var buttonSetting: UIButton!
    
    @IBOutlet weak var buttonMyComplaints: UIButton!
    @IBOutlet weak var labelMyApplications: UIButton!
    
    @IBOutlet weak var buttonTotalSchool: UIButton!
    @IBOutlet weak var buttonSelectDisability: UIButton!
    @IBOutlet weak var buttonLocation: UIButton!
    
    private var tempDistrict: District? = nil
    private var tempDisability: Disability? = nil
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        imageUser.roundCorner(withRadis: imageUser.viewHeight.half)
        
        buttonMyComplaints.makeItThemeRegular(12.0, .appLight, .appGreen)
        labelMyApplications.makeItThemeRegular(12.0, .appLight, .appGreen)
        
        buttonTotalSchool.makeItThemeRegular(10.0, .textDark, .appBGDark)
        buttonSelectDisability.makeItThemeRegular(10.0, .textDark, .appBGDark)
        buttonLocation.makeItThemeRegular(10.0, .textDark, .appBGDark)
        
        if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
            buttonTotalSchool.semanticContentAttribute = .forceLeftToRight
            buttonSelectDisability.semanticContentAttribute = .forceLeftToRight
            buttonLocation.semanticContentAttribute = .forceLeftToRight
        } else {
            buttonTotalSchool.semanticContentAttribute = .forceRightToLeft
            buttonSelectDisability.semanticContentAttribute = .forceRightToLeft
            buttonLocation.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        viewModel.delegate = self
        viewModel.fetchInstitutes()
        
        setUpCollectionView()
        
        buttonSetting.addTapGestureRecognizer {
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: SettingViewController.self)
            openModulePopOver(controller: view)
        }
        
        
        buttonTotalSchool.addTapGestureRecognizer {[weak self] in
            self?.viewModel.resetAll()
        }
        buttonSelectDisability.addTapGestureRecognizer {[weak self] in
            self?.setUpPickerViewDisabilities()
        }
        buttonLocation.addTapGestureRecognizer {[weak self] in
            self?.setUpPickerViewDistrict()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelUserName.text = USM.shared.getUserFullName()
        labelLocation.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setUpCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appBG
        
        collectionView.register(UINib(nibName: "InstituteCell", bundle: nil), forCellWithReuseIdentifier: InstituteCell.reuseIdentifier)
        
        createDataSource()
    }
    
}

extension UserHomeViewController: UserHomeVM {
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
            self?.buttonSelectDisability.setTitle(self?.viewModel.getDisabilityName(), for: .normal)
            self?.buttonLocation.setTitle( self?.viewModel.getDistrictName(), for: .normal)
            self?.reloadData()
        }
    }
}

extension UserHomeViewController {
    func setupNavigation() {
//        self.setLogo()
//        self.setNavBarColor(.appBlue)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension UserHomeViewController { // Create Compositional Layout
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
extension UserHomeViewController {
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<PoitsSection,
                                                        InstituteModel>(collectionView: self.collectionView) { _, indexPath, app in
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: InstituteCell.reuseIdentifier, for: indexPath) as? InstituteCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: app)
//            cell.delegate = self
            return cell
        }
    }
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PoitsSection, InstituteModel>()
        snapshot.appendSections([.all])
        snapshot.appendItems(viewModel.getInstitutes(), toSection: .all)
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        constraintHeight.constant = collectionView.contentSize.height + 30
        collectionView.layoutIfNeeded()
    }
}
extension UserHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.selectedProduct(product: dataProds[indexPath.row])
        DispatchQueue.main.async {[weak self] in
            let storyboard = getStoryBoard(.main)
            let view = storyboard.instantiateViewController(ofType: InstituteDetailViewController.self)
            view.selectedInstitute = self?.viewModel.getInstitutes()[indexPath.row]
            openModuleOnNavigation(from: self, controller: view)
        }
    }
}

extension UserHomeViewController { // Make Search Section
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
                                                       heightDimension: .absolute(147))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                      
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}


extension UserHomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func setUpPickerViewDistrict() {
        var tfView = UITextField(frame: CGRect(x: -100, y: -500, width: 30, height: 30))
        
        let picker: UIPickerView
        picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        picker.backgroundColor = .appBG
        
        picker.delegate = self
        picker.dataSource = self
        
        picker.tag = 901
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .appBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker(_:)))
        doneButton.tag = 901
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker(_:)))
        cancelButton.tag = 901
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        tfView.inputView = picker
        tfView.inputAccessoryView = toolBar
        
        self.view.addSubview(tfView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            tfView.becomeFirstResponder()
        }
    }
    
    private func setUpPickerViewDisabilities() {
        
        var tfView = UITextField(frame: CGRect(x: -100, y: -500, width: 30, height: 30))
        
        let picker: UIPickerView
        picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        picker.backgroundColor = .appBG
        
        picker.delegate = self
        picker.dataSource = self
        
        picker.tag = 902
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .appBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker(_:)))
        doneButton.tag = 902
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker(_:)))
        cancelButton.tag = 902
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        tfView.inputView = picker
        tfView.inputAccessoryView = toolBar
        
        self.view.addSubview(tfView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            tfView.becomeFirstResponder()
        }
    }
    
    @objc func cancelPicker(_ sender: UIButton) {
        self.view.endEditing(true)
        print(sender.tag)
    }
    
    @objc func donePicker(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 901 {
            guard let district = tempDistrict else { return }
            viewModel.setDistrict(district: district)
        }
        if sender.tag == 902 {
            guard let disability = tempDisability else { return }
            viewModel.setDisability(disability: disability)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 901 {
            return APPMetaDataHandler.shared.getDistricts().count
        }
        if pickerView.tag == 902 {
            return APPMetaDataHandler.shared.getDisabilities().count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 901 {
            return APPMetaDataHandler.shared.getDistricts()[row].name
        }
        if pickerView.tag == 902 {
            return APPMetaDataHandler.shared.getDisabilities()[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 901 {
            tempDistrict =  APPMetaDataHandler.shared.getDistricts()[row]
            return
        }
        if pickerView.tag == 902 {
            tempDisability = APPMetaDataHandler.shared.getDisabilities()[row]
            return
        }
    }
}
