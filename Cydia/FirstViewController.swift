//
//  FirstViewController.swift
//  Cydia
//
//  Created by ituser on 11/4/16.
//  Copyright © 2016 Abraham Masri. All rights reserved.
//

import UIKit
import WebKit

class FirstViewController: UIViewController, WKNavigationDelegate {

    private var webView: WKWebView!

    @IBOutlet weak var loadingStack: UIStackView!

    @IBOutlet weak var reloadButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Web view created in code (UIWebView was removed from the SDK).
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 50, right: 0)
        webView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
        webView.isHidden = true
        view.insertSubview(webView, at: 0)
        NSLayoutConstraint.activate([
            webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            webView.widthAnchor.constraint(equalTo: view.widthAnchor),
            webView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])

        var _ = Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
    }

    // MARK: Functions

    // Loads the home page
    func loadHomepage() {

        // Get the local homepage file
        let htmlFile = Bundle.main.path(forResource: "homepage", ofType: "htm")
        var htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)

        // Set app name
        htmlString = htmlString?.replacingOccurrences(of: "to Cydia", with: "to \(appName)")

        // Add system info to the HTML String
        htmlString = htmlString?.replacingOccurrences(of: ", iOS 10", with: "\(getDeviceModel()), iOS \(getSystemVersion())")
        htmlString = htmlString?.replacingOccurrences(of: ", Cydia", with: ", Cydia \(cydiaVersion)")
        htmlString = htmlString?.replacingOccurrences(of: "UDID_REPLACE", with: UIDevice.current.identifierForVendor!.uuidString.lowercased().replacingOccurrences(of: "-", with: ""))

        webView.loadHTMLString(htmlString!, baseURL: Bundle.main.resourceURL)
    }

    // must be internal or public.
    func update() {

        loadHomepage()

        webView.isHidden = false
        loadingStack.isHidden = true

        reloadButton.tintColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)
    }

    // MARK: Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.isHidden = false
    }

    @IBAction func aboutTapped(sender: AnyObject) {

        let alert = UIAlertController(title: "About Cydia Installer", message: "Copyright © 2008-2016", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
