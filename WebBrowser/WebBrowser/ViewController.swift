//
//  ViewController.swift
//  WebBrowser
//
//  Created by Valkyrie on 21/03/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet
    var webView: WKWebView!
    @IBOutlet
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstPageURL: URL?
        
        if let lastURL = UserDefaults.standard.url(forKey: lastPageURLDefaultKey) {
            firstPageURL = lastURL
        } else {
            firstPageURL = URL(string: "https://www.google.com")
        }
        
        guard let pageURL = firstPageURL else {
            return
        }
        
        self.webView.load(URLRequest(url: pageURL))
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    func showNetworking() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideNetworking() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish navigation")
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.lastPageURL = webView.url
        }
        
        webView.evaluateJavaScript("document.title") { (value: Any?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let title = value as? String else {
                return
            }
            
            self.navigationItem.title = title
        }
        self.hideNetworking()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("did fail navigation")
        print("\(error.localizedDescription)")
        
        self.hideNetworking()
    
        let alert = UIAlertController(title: "알림", message: "오류발생!\n" + error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("did start navigation")
        self.showNetworking()
    }
}
