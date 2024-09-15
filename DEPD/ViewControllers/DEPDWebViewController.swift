//
//  DEPDWebViewController.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 15/09/2024.
//

import UIKit
import WebKit

class DEPDWebViewController: BaseViewController {
    
    var webView: WKWebView!
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackButton(.textDark).addTapGestureRecognizer {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        // Initialize and configure the WKWebView
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        // Load the URL if the urlString is set
        if let urlString = urlString, let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
}

