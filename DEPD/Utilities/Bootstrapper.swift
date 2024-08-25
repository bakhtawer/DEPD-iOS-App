//
//  Bootstrapper.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

struct Bootstrapper {
    
    var window: UIWindow
    static var instance: Bootstrapper?
    
    private init(window: UIWindow) {
        self.window = window
    }
    
    static func initialize(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        instance = Bootstrapper(window: makeNewWindow())
        instance!.bootstrap()
    }
    
    mutating func bootstrap() {
        //Decision point to show Onboarding, Login, Home.
        showSetupView()
        window.makeKeyAndVisible()
    }
    
    static func startAppAfterSetup() {
        instance!.startAppAfterSetup()
    }
    
    static func createSplash() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showSetupView()
    }
    
    static func createLogin(screenType: LoginScreenType) {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showLogin(screenType: screenType)
    }

    static func createLoginSignup() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showSignupLogin()
    }
    
    static func createHome() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showHome()
    }
    
    static func decideScreenToOpen() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.makeDecisonToOpenAppInState()
    }
    
    static func createLanguageSelection() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showLanguageSelection()
    }
    
    static func createshowRegisterAsSelectionOne() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showRegisterAsSelectionOne()
    }
    
    static func createInclusiveScreen() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showInclusiveScreen()
    }
}

extension Bootstrapper {
    
    private static func makeNewWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { fatalError()
        }
        return window
    }
    
    private func showSetupView() {
        let storyboard = getStoryBoard(.main)
        let view = storyboard.instantiateViewController(ofType: SplashViewController.self)
        self.window.rootViewController = view
    }
    
    private func startAppAfterSetup() {
        self.getMetaData()
    }
    
    private func getMetaData() {
        self.makeDecision()
    }
    
    private func makeDecision() {
        DispatchQueue.main.async {
            self.makeDecisonToOpenAppInState()
        }
    }
    
    private func makeDecisonToOpenAppInState() {
        
        Bootstrapper.createLanguageSelection()
        

//        let isLogin = UserDefaults.userLogin
//        
//        if (isLogin) {
//          // User is signed in.
//            UserManager().getUser {
//                DispatchQueue.main.async {
//                    Bootstrapper.createHome()
//                }
//            }
//        } else {
//          // No user is signed in.
//            Bootstrapper.createLoginSignup()
//        }
    }
    
    private func showLanguageSelection() {
        let storyboard = getStoryBoard(.main)
        let view = storyboard.instantiateViewController(ofType: LanguageSelectionViewController.self)
        let nav = UINavigationController(rootViewController: view)
        self.window.rootViewController = nav
    }
    
    private func showInclusiveScreen() {
        let storyboard = getStoryBoard(.main)
        let view = storyboard.instantiateViewController(ofType: InclusiveScreen.self)
        let nav = UINavigationController(rootViewController: view)
        self.window.rootViewController = nav
    }
    
    private func showRegisterAsSelectionOne() {
        let storyboard = getStoryBoard(.main)
        let view = storyboard.instantiateViewController(ofType: RegisterAsSelectionOne.self)
        let nav = UINavigationController(rootViewController: view)
        self.window.rootViewController = nav
    }
    
    private func showHome() {
        let storyboard = getStoryBoard(.main)
        //        let view = storyboard.instantiateViewController(ofType: UserHomeViewController.self)
        
        let viewController = storyboard.instantiateViewController(identifier: "UserHomeViewController") {coder in
            let viewModel = UserHomeViewModel()
            let vc = UserHomeViewController(coder: coder, viewModel: viewModel)
            return vc
        }
        
        let nav = UINavigationController(rootViewController: viewController)
        self.window.rootViewController = nav
    }
    
    private func showSignupLogin() {
//        let storyboard = getStoryBoard(.main)
//        let view = storyboard.instantiateViewController(ofType: RegisterViewController.self)
//        let nav = UINavigationController(rootViewController: view)
////        self.window.rootViewController = nav
//        view.modalPresentationStyle = .fullScreen
//        self.window.rootViewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    private func showLogin(screenType: LoginScreenType) {
        let storyboard = getStoryBoard(.main)
        let view = storyboard.instantiateViewController(ofType: LoginViewController.self)
        view.screenType = screenType
        let nav = UINavigationController(rootViewController: view)
        self.window.rootViewController = nav
    }
}
