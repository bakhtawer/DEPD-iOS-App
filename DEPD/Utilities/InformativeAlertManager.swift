//
//  InformativeAlertManager.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 23/05/2024.
//
//

import SwiftMessages
import UIKit

protocol ISippyMesagesManager: AnyObject {
    // do someting...
}

typealias SMM = SippyMesagesManager

class SippyMesagesManager: ISippyMesagesManager {
    // do someting...
    static let shared = SippyMesagesManager()
    
    init() {}
    
    func showWarning(title: String, message: String) {
        DispatchQueue.main.async {
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(.warning)
            warning.configureDropShadow()
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
            warning.configureContent(title: "\(title)", body: "\(message)", iconText: iconText)
            warning.button?.isHidden = true
            //        warning.backgroundView.backgroundColor = UIColor.
            //        warning.bodyLabel?.textColor = UIColor.white
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationStyle = .top
            warningConfig.dimMode = .gray(interactive: true)
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            SwiftMessages.show(config: warningConfig, view: warning)
        }
    }
    func showStatusInfo(message: String) {
        DispatchQueue.main.async {
            let status = MessageView.viewFromNib(layout: .statusLine)
            status.backgroundView.backgroundColor = UIColor.appGreen
            status.bodyLabel?.textColor = UIColor.white
            status.configureContent(body: "\(message)")
            var statusConfig = SwiftMessages.defaultConfig
            statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            statusConfig.preferredStatusBarStyle = .lightContent
            SwiftMessages.show(config: statusConfig, view: status)
        }
    }
    func showStatusSuccess(message: String) {
        DispatchQueue.main.async {
            let success = MessageView.viewFromNib(layout: .cardView)
            success.configureTheme(.success)
            success.configureDropShadow()
            success.configureContent(title: "Success", body: "\(message)")
            success.button?.isHidden = true
            var successConfig = SwiftMessages.defaultConfig
            successConfig.duration = .seconds(seconds: 3)
            successConfig.presentationStyle = .center
            successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            SwiftMessages.show(config: successConfig, view: success)
        }
    }
    func showBottomInfo(title: String, message: String) {
        DispatchQueue.main.async {
            let info = MessageView.viewFromNib(layout: .cardView)
            info.configureTheme(.info)
            info.button?.isHidden = true
            info.configureContent(title: "\(title)", body: "\(message)")
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = .bottom
            
            infoConfig.duration = .seconds(seconds: 3)
            SwiftMessages.show(config: infoConfig, view: info)
        }
    }
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            let error = MessageView.viewFromNib(layout: .cardView)
            error.configureTheme(.error)
            error.configureContent(title: "\(title)", body: "\(message)")
            error.button?.isHidden = true
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.duration = .seconds(seconds: 3)
            SwiftMessages.show(config: infoConfig, view: error)
        }
    }
    func showSimpleMessage() {
        DispatchQueue.main.async {
            let error = MessageView.viewFromNib(layout: .tabView)
            error.configureTheme(.error)
            error.configureContent(title: "Error", body: "Something is horribly wrong!")
            error.button?.setTitle("Stop", for: .normal)
            
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(.warning)
            warning.configureDropShadow()
            
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
            warning.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
            warning.button?.isHidden = true
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)

            let success = MessageView.viewFromNib(layout: .cardView)
            success.configureTheme(.success)
            success.configureDropShadow()
            success.configureContent(title: "Success", body: "Something good happened!")
            success.button?.isHidden = true
            var successConfig = SwiftMessages.defaultConfig
            successConfig.presentationStyle = .center
            successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)

            let info = MessageView.viewFromNib(layout: .messageView)
            info.configureTheme(.info)
            info.button?.isHidden = true
            info.configureContent(title: "Info", body: "This is a very lengthy and informative info message that wraps across multiple lines and grows in height as needed.")
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = .bottom
            infoConfig.duration = .seconds(seconds: 0.25)

            let status = MessageView.viewFromNib(layout: .statusLine)
            status.backgroundView.backgroundColor = UIColor.purple
            status.bodyLabel?.textColor = UIColor.white
            status.configureContent(body: "A tiny line of text covering the status bar.")
            var statusConfig = SwiftMessages.defaultConfig
            statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)

            let status2 = MessageView.viewFromNib(layout: .statusLine)
            status2.backgroundView.backgroundColor = UIColor.orange
            status2.bodyLabel?.textColor = UIColor.white
            status2.configureContent(body: "Switched to light status bar!")
            var status2Config = SwiftMessages.defaultConfig
            status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            status2Config.preferredStatusBarStyle = .lightContent

            SwiftMessages.show(view: error)
            SwiftMessages.show(config: warningConfig, view: warning)
            SwiftMessages.show(config: successConfig, view: success)
            SwiftMessages.show(config: infoConfig, view: info)
            SwiftMessages.show(config: statusConfig, view: status)
            SwiftMessages.show(config: status2Config, view: status2)
        }
    }
    
    func noInternetConnectionPopUp() {
        DispatchQueue.main.async {

            let title = "No Internet Connection"
            let message = "Please verify you are connected to wifi or cellular network"

            let view = MessageView.viewFromNib(layout: .cardView)

            var config = SwiftMessages.Config()
            view.configureTheme(backgroundColor: UIColor.appLight,
                                foregroundColor: UIColor.black,
                                iconImage: UIImage(named: "snoWifi"), iconText: nil)

//            view.iconImageView?.setOverlay(withColor: UIColor.black)

            view.configureContent(title: title,
                                  body: message)

            view.button?.isHidden = true

            view.tapHandler = { _ in SwiftMessages.hide() }

            // Slide up from the bottom.
            config.presentationStyle = .top

            // Display in a window at the specified window level: UIWindow.Level.statusBar
            // displays over the status bar while UIWindow.Level.normal displays under.
            config.presentationContext = .window(windowLevel: .alert)

            // Disable the default auto-hiding behavior.
            //        config.duration = .automatic
            config.duration = .seconds(seconds: 5.0)

            // Dim the background like a popover view. Hide when the background is tapped.
            config.dimMode = .gray(interactive: true)

            // Disable the interactive pan-to-hide gesture.
            config.interactiveHide = true

            // Specify a status bar style to if the message is displayed directly under the status bar.
            config.preferredStatusBarStyle = .lightContent

            // Specify one or more event listeners to respond to show and hide events.
            config.eventListeners.append { event in
                if case .didHide = event { print("yep") }
            }

            SwiftMessages.show(config: config, view: view)
        }
    }
}
