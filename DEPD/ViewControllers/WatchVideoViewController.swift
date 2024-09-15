//
//  WatchVideoViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 06/09/2024.
//

import UIKit
import WebKit

class WatchVideoViewController: BaseViewController {
    
    @IBOutlet weak var viewWatchVideo: UIView!
    @IBOutlet weak var buttonback: DEPDButton!
    
    var webView: WKWebView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutSubviews()
        view.layoutIfNeeded()
        view.setNeedsDisplay()
        
        setView()
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.viewWatchVideo.frame.width, height: self.viewWatchVideo.frame.height))

        viewWatchVideo.backgroundColor = .appDarkBG
        // Add the WKWebView to the view
        self.viewWatchVideo.addSubview(webView)
        
        if let url = URL(string: "https://www.youtube.com/embed/R9m-2t0iKEE?playsinline=1&autoplay=1&modestbranding=1&showinfo=0&rel=0&controls=0") {
           let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setView() {
        buttonback.makeItTheme(text: "back".localized(),
                                 .bold, 18, .appLight)
    }
}

extension WatchVideoViewController {
    func setupNavigation() {
        self.setLogo()
        self.setNavBarColor(.appBG)
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButton(.appDarkBG).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
