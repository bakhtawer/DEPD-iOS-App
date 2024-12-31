//
//  SettingViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 07/07/2024.
//

import UIKit

class SettingViewController: BaseViewController {
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var labeluser: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Sample data for the table
    private let settings: [(title: String, subtitle: String?, style: UITableViewCell.CellStyle, url: String?)] = [
        (title: "About Us".localized(), subtitle: nil, style: .default, url: "https://depdportal.com"),
        (title: "Contact Us".localized(), subtitle: nil, style: .default, url: "https://depdportal.com"),
        (title: "Terms & Conditions".localized(), subtitle: nil, style: .default, url: "https://depdportal.com"),
        (title: "Privacy Policy".localized(), subtitle: nil, style: .default, url: "https://depdportal.com"),
        (title: "FAQ's".localized(), subtitle: nil, style: .default, url: "https://depdportal.com/faqs/"),
        (title: "Help/Complain".localized(), subtitle: nil, style: .default, url: "https://depdportal.com/complain-main/"),
    ]
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonLogout.makeItThemePrimary()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labeluser.text = USM.shared.getUserFullName()
        
        buttonLogout.setTitle("logout".localized(), for: .normal)
        
        
        buttonLogout.addTapGestureRecognizer {
            UserSessionManager.shared.LogoutUser()
            Bootstrapper.createSplash()
        }
        
        labelVersion.numberOfLines = 0
        labelVersion.text = """
support@depdportal.com
DEPD, Building No, 06, 3rd Floor, Sindh Secretariat. Opposite People's Square
021-33408768

\(Bundle.main.releaseVersionNumberPretty)
"""
        labelVersion.makeItTheme(.bold, 12, .textLightGray)
        
        imageuser.roundCorner(withRadis: imageuser.viewHeight.half)
        imageuser.applyShadow()
        guard let image = URL(string: USM.shared.getUserImage()) else { return }
        imageuser.contentMode = .scaleAspectFill
        imageuser.kf.setImage(with: image,
                              placeholder: UIImage(named: "studentplacehoder"))
    }
}
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings[indexPath.row]
        let cell = UITableViewCell(style: setting.style, reuseIdentifier: nil)
        cell.textLabel?.text = setting.title
        cell.detailTextLabel?.text = setting.subtitle
        cell.textLabel?.makeItTheme(.medium, 14, .textDark)
        cell.accessoryType = .disclosureIndicator // Add an arrow accessory
        cell.selectionStyle = .none
        return cell
    }
}
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        switch indexPath.row {
        default:
            DispatchQueue.main.async {[weak self] in
                self?.openUrl(url: setting.url ?? "")
            }
        }
    }
    
    private func openUrl(url: String) {
        let webVC = DEPDWebViewController()
        webVC.urlString = url
        openModuleOnNavigation(from: self, controller: webVC)
    }
}
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0").\(buildVersionNumber ?? "")"
    }
}
