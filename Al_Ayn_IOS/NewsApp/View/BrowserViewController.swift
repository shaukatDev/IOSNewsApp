//
//  BrowserViewController.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 05/02/22.
//

import Foundation
import UIKit
import WebKit

class BrowserViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    var webView: WKWebView!
    var url:String?
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let myURL = URL(string:url ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.frame = self.view.frame
        webView.navigationDelegate = self
        webView.load(myRequest)
        
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation:
                 WKNavigation!) {
        
        activityIndicator.stopAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation
                 navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation:
                 WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Oops", message: "Try again?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {  action in
            webView.reload()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler:
                                        { action in
            self.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
