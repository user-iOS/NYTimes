//
//  DetailViewController.swift
//  NYCAssessment
//
//  Created by Paurush on 29/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var nycModel: NYCModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.title = "NYC Detail News"
        if let url = URL(string: nycModel.url) {
            self.activityIndicator.startAnimating()
            self.wkWebView.navigationDelegate = self
            self.wkWebView.load(URLRequest(url: url))
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.stopAnimating()
        print(error.localizedDescription)
    }
}

