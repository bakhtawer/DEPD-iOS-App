//
//  Storyboard+extention.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType _: T.Type,
                                                        withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let controller = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateNavigationController controller unwrapped failed")
            fatalError()
        }
        return controller
    }
    
    func instantiateNavigationController<T: UINavigationController>(ofType _: T.Type,
                                                                    withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let navigationController = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateNavigationController navigation controller unwrapped failed")
            fatalError()
        }
        return navigationController
    }
}
extension UINavigationController {
    func containsViewController(ofKind kind: AnyClass) -> Bool {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
