//
//  EmployerHubViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 29/12/2024.
//

import UIKit

class EmployerHubViewController: MVVMViewController<EmployerHomeViewModel> {
    
    @IBOutlet weak var mainIcon: UIView!
    @IBOutlet weak var mainIconImage: UIImageView!
    @IBOutlet weak var viewTopBG: UIView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolLocation: UILabel!
    @IBOutlet weak var schoolProfilePercentage: UILabel!
    
    @IBOutlet weak var viewBottom: BottomView!
    
    @IBOutlet weak var viewApplications: UIView!
    @IBOutlet weak var buttonViewApplications: UIButton!
    @IBOutlet weak var buttonEditYourProfile: UIButton!
    
    @IBOutlet weak var viewTotalApplications: UIView!
    @IBOutlet weak var labelTotalApplications: UILabel!
    
    @IBOutlet weak var viewHiredPerson: UIView!
    @IBOutlet weak var labelHiredPerson: UILabel!
    
    @IBOutlet weak var viewFindEmployee: UIView!
    @IBOutlet weak var labelFindEmployee: UILabel!
    
    @IBOutlet weak var viewConfirmHiring: UIView!
    @IBOutlet weak var labelConfirmHiring: UILabel!
    
    @IBOutlet weak var viewAdvertiseVacancy: UIView!
    @IBOutlet weak var labelAdvertiseVacancy: UILabel!
    
    @IBOutlet weak var viewPostJob: UIView!
    @IBOutlet weak var labelPostJob: UILabel!
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewBottom.setLanguage()
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        buttonViewApplications.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: EmployerProfileDetailsController.self)
                openModuleOnNavigation(from: self, controller: view)
            }
        }
        
        viewTotalApplications.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(identifier: "EmployerListViewController") { coder in
                    let viewModel = EmployerHomeViewModel()
                    let vc = EmployerListViewController(coder: coder, viewModel: viewModel)
                    return vc
                }
                if let view = view as? EmployerListViewController {
                    view.screenType = .totalApplications
                    openModuleOnNavigation(from: self, controller: view)
                }
            }
        }
        viewHiredPerson.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(identifier: "EmployerListViewController") { coder in
                    let viewModel = EmployerHomeViewModel()
                    let vc = EmployerListViewController(coder: coder, viewModel: viewModel)
                    return vc
                }
                if let view = view as? EmployerListViewController {
                    view.screenType = .hiredPerson
                    openModuleOnNavigation(from: self, controller: view)
                }
            }
        }
        viewFindEmployee.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(identifier: "EmployerListViewController") { coder in
                    let viewModel = EmployerHomeViewModel()
                    let vc = EmployerListViewController(coder: coder, viewModel: viewModel)
                    return vc
                }
                if let view = view as? EmployerListViewController {
                    view.screenType = .findEmployee
                    openModuleOnNavigation(from: self, controller: view)
                }
            }
        }
        viewConfirmHiring.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(identifier: "EmployerListViewController") { coder in
                    let viewModel = EmployerHomeViewModel()
                    let vc = EmployerListViewController(coder: coder, viewModel: viewModel)
                    return vc
                }
                if let view = view as? EmployerListViewController {
                    view.screenType = .confirmHiring
                    openModuleOnNavigation(from: self, controller: view)
                }
            }
        }
        viewAdvertiseVacancy.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(identifier: "EmployerListViewController") { coder in
                    let viewModel = EmployerHomeViewModel()
                    let vc = EmployerListViewController(coder: coder, viewModel: viewModel)
                    return vc
                }
                if let view = view as? EmployerListViewController {
                    view.screenType = .advertiseVacancy
                    openModuleOnNavigation(from: self, controller: view)
                }
            }
        }
        viewPostJob.addTapGestureRecognizer {
            DispatchQueue.main.async {[weak self] in
                let storyboard = getStoryBoard(.main)
                let view = storyboard.instantiateViewController(ofType: FormBuilderViewController.self)
                view.type = .postJob
                openModuleOnNavigation(from: self, controller: view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setView()
    }
    
    private func setView() {
        mainIcon.roundCorner(withRadis: mainIcon.viewHeight.half)
        mainIconImage.roundCorner(withRadis: mainIconImage.viewHeight.half)
//        viewTopBG.backgroundColor = .appLight
//        viewTopBG.applyShadow()
        
        
        viewTotalApplications.roundCorner(withRadis: 6)
        labelTotalApplications.text = "total_applications".localized()
        labelTotalApplications.makeItTheme(.bold, 12)
        viewHiredPerson.roundCorner(withRadis: 6)
        labelHiredPerson.text = "hired_person".localized()
        labelHiredPerson.makeItTheme(.bold, 12)
        viewFindEmployee.roundCorner(withRadis: 6)
        labelFindEmployee.text = "find_employee".localized()
        labelFindEmployee.makeItTheme(.bold, 12)
        viewConfirmHiring.roundCorner(withRadis: 6)
        labelConfirmHiring.text = "confirm_hiring".localized()
        labelConfirmHiring.makeItTheme(.bold, 12)
        viewAdvertiseVacancy.roundCorner(withRadis: 6)
        labelAdvertiseVacancy.text = "advertise_vacancy".localized()
        labelAdvertiseVacancy.makeItTheme(.bold, 12)
        viewPostJob.roundCorner(withRadis: 6)
        labelPostJob.text = "post_job".localized()
        labelPostJob.makeItTheme(.bold, 12)
        

        buttonViewApplications.setTitle("\("edit_profile".localized())", for: .normal)
        buttonEditYourProfile.setTitle("\("my_applications".localized())", for: .normal)
        buttonViewApplications.makeItThemePrimary(14)
        buttonEditYourProfile.makeItThemeWhitePrimary(14)

        schoolName.text = USM.shared.getUserFullName()
        schoolLocation.text = USM.shared.getUser().companyDetailInfo?.location
        schoolProfilePercentage.text = "\(USM.shared.getUser().percentage ?? 0)% \("profile_completed".localized())"
        
        schoolName.makeItTheme(.bold, 16, .textDark, .center)
        schoolLocation.makeItTheme(.regular, 14, .textLightGray, .center)
        schoolProfilePercentage.makeItTheme(.regular, 14, .appBlue, .center)
        
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        mainIconImage.contentMode = .scaleAspectFill
        mainIconImage.kf.setImage(with: image,
                                  placeholder: UIImage(named: "studentplacehoder"))
    }
}

extension EmployerHubViewController {
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
