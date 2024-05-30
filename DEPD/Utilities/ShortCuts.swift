//
//  ShortCuts.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit
import SystemConfiguration

enum StoryBoard: String {
    case main = "Main"
}

func getStoryBoard(_ storyBoard: StoryBoard) -> UIStoryboard {
    return UIStoryboard(name: storyBoard.rawValue, bundle: nil)
}

func openModuleOnFullScreen(controller: UIViewController) {
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    UIViewController.top().present(nav, animated: true, completion: nil)
}
func openModuleOverFullScreen(controller: UIViewController) {
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .overFullScreen
    UIViewController.top().present(nav, animated: true, completion: nil)
}
func openModuleOnNavigation(from: UIViewController?, controller: UIViewController?) {
    guard let cFrom = from, let cTo = controller else { return  }
    cFrom.navigationController?.pushViewController(cTo, animated: true)
}

func getApiHeaders() -> [String: String] {
    
    var headers = [String: String]()
    
//    headers["Content-Type"] = "application/json, charset=utf-8"
//
//    headers["Accept"] = "application/json"
//
    headers["x-device-type"] = "ios"
//
    headers["x-os-version"] = "\(UIDevice.current.systemVersion)"
//
    headers["x-app-version"] = appVersionWithBuildNumber()
    
    headers["x-app-name"] = "Points"
//
//    headers["secret"] = NetworkConstants.getClientSecret()
//
//    headers["lang"] = currentLanguage().rawValue
    headers["Content-Type"] = "application/json"
    headers["accept"] = "*/*"
    
//    if let token = UserDefaults.authenticationToken {
//        print("Token is: Bearer \(token)")
//        !token.isEmpty ? (headers["Authorization"] = "Bearer \(token)") : ()
//    }
    
    return headers
}

func isInternetAvailable() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

func appVersionWithBuildNumber() -> String {
    guard let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
          let _ = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
        return "0.0"
    }
    return "\(shortVersion)"
}

extension String {
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        return self.compare(otherVersion, options: .numeric)
    }
}
