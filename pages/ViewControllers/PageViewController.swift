//
//  PageViewController.swift
//  pages
//
//  Created by Vladimir Psyukalov on 24.01.2020.
//  Copyright © 2020 ZUZEX LLC. All rights reserved.
//

import Cocoa
import WebKit

class PageViewController: ViewController {
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var progressIndicator: ProgressIndicator!
    
    @IBOutlet weak var stackView: NSStackView!
    
    @IBOutlet weak var errorTextField: NSTextField!
    
    @IBOutlet weak var refreshButtonA: NSButton!
    @IBOutlet weak var refreshButtonB: NSButton!
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    
    @IBOutlet weak var box: NSBox!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var request: URLRequest?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        localize()
        applyNavigationButtons()
        toggle(isSuccess: true)
        loadRequest()
    }
    
    override func popoverDidShow(animated: Bool) {
        super.popoverDidShow(animated: animated)
        applyPercent()
    }
    
    override func popoverDidHide(animated: Bool) {
        super.popoverDidHide(animated: animated)
        applyPercent()
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        applyPercent()
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        applyPercent()
    }
    
    override func mouseMoved(with event: NSEvent) {
        var location = view.window?.mouseLocationOutsideOfEventStream ?? .zero
        // Fix location;
        location.x = location.x - 13.0
        location.y = location.y - 13.0
        applyPercent(percent(by: location.y))
    }
    
    // MARK: - Public
    
    func load(url: String?) {
        if let url = URL(string: string(from: url)) {
            request = URLRequest(url: url)
        }
        loadRequest()
    }
    
    func loadRequest() {
        if let request = request {
            // Property webView can be nil;
            webView?.load(request)
        }
    }
    
    // MARK: - Private
    
    private func string(from url: String?) -> String {
        let string = url ?? ""
        return string.hasPrefix("http") ? string : ("http://" + string)
    }
    
    private func setup() {
        webView.configuration.preferences.javaScriptEnabled = true
    }
    
    private func localize() {
        refreshButtonA.title = "l_refresh".localized
    }
    
    private func applyError(_ error: Error?) {
        toggle(isSuccess: error == nil)
        errorTextField.stringValue = error?.localizedDescription ?? ""
    }
    
    private func toggle(isSuccess: Bool) {
        webView.isHidden = !isSuccess
        stackView.isHidden = isSuccess
    }
    
    private func percent(by value: CGFloat) -> CGFloat {
        var result = CGFloat(0.0)
        let heightA = SettingsService.height
        let heightB = heightConstraint.constant + bottomConstraint.constant
        let heightC = heightA + heightB
        if value < heightC && value > heightB {
            result = (value - heightB) / heightA
        } else if value >= heightC {
            result = 1.0
        } else {
            result = 0.0
        }
        return 1.0 - result
    }
    
    private func applyPercent(_ percent: CGFloat = 0.0) {
        let y = -(1.0 - percent) * (heightConstraint.constant + bottomConstraint.constant)
        let transform = CGAffineTransform(translationX: 0.0, y: y)
        box.alphaValue = percent
        box.layer?.setAffineTransform(transform)
    }
    
    private func applyNavigationButtons() {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
    // MARK: - Action
    
    @IBAction func refreshButtonAction(_ sender: NSButton) {
        webView.reload()
    }
    
    @IBAction func backButtonAction(_ sender: NSButton) {
        webView.goBack()
    }
        
    @IBAction func forwardButtonAction(_ sender: NSButton) {
        webView.goForward()
    }
}

extension PageViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressIndicator.startAnimation(nil)
        applyNavigationButtons()
        toggle(isSuccess: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressIndicator.stopAnimation(nil)
        applyNavigationButtons()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressIndicator.stopAnimation(nil)
        applyNavigationButtons()
        applyError(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressIndicator.stopAnimation(nil)
        applyNavigationButtons()
        applyError(error)
    }
}
