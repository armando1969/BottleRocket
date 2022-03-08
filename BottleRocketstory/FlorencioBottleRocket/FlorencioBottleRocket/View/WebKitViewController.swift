//
//  TemplateWebKitViewController.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/4/22.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var brToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isTranslucent = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.barTintColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
        return toolbar
    }()
    
    private lazy var brBackButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(backAction))
        button.tintColor = .white
        return button
    }()
    
    private lazy var brReloadButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_webRefresh"), style: .plain, target: self, action: #selector(reloadAction))
        button.tintColor = .white
        return button
    }()
    
    private lazy var goButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: self, action: #selector(goAction))
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpToolbar()
        setUpWebView()
        loadWebView("https://www.bottlerocketstudios.com")
    }
    
    private func setUpToolbar() {
        brToolbar.setItems([brBackButton, brReloadButton, goButton], animated: false)
        
        view.addSubview(brToolbar)
        
        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        brToolbar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        brToolbar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        brToolbar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func setUpWebView() {
        view.addSubview(webView)
        
        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        webView.topAnchor.constraint(equalTo: brToolbar.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func loadWebView(_ url: String) {
        guard let url = URL(string: url)
        else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @objc private func backAction() {
        webView.goBack()
    }
    
    @objc private func reloadAction() {
        webView.reload()
    }
    
    @objc private func goAction() {
        webView.goForward()
    }
}
