//
//  SplashViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dump(UIFont.familyNames)
//        dump(UIFont.fontNames(forFamilyName: "Roboto"))
//        dump(UIFont.fontNames(forFamilyName: "Jameel-Noori-Sindhi"))
//        dump(UIFont.fontNames(forFamilyName: "Lateefi-Regular-Urdu"))
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {[weak self] in
            self?.canGoForword()
        })
    }
    
    func canGoForword() {
        DispatchQueue.main.async {
            Bootstrapper.decideScreenToOpen()
        }
    }
}
