//
//  ViewController.swift
//  BrawHW
//
//  Created by Stanislav Sobolevsky on 25.10.22.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var seachField: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    var myActivityIndicator = UIActivityIndicatorView() // мой индикатор загрузки
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myActivityIndicator.center = self.view.center
        myActivityIndicator.style = UIActivityIndicatorView.Style.medium
                view.addSubview(myActivityIndicator)
        self.webView.addObserver(self, forKeyPath:#keyPath(WKWebView.isLoading), options: .new, context: nil)
    }

    @IBAction func seachButton(_ sender: UIButton) {
        func searchTextOnGoogle(text: String) {
            let textComponent = text.components(separatedBy: " ")
                        let searchString = textComponent.joined(separator: "+")
                        let url = URL(string: "https://www.google.com/search?q=" + searchString)
                        let urlRequest = URLRequest(url: url!)
                        webView.load(urlRequest)
        }
        if let urlString = seachField.text {
            if urlString.starts(with: "http://") || urlString.starts(with: "https://") {
                            webView.loadUrl(string: urlString)
                } else if urlString.contains("www") {
                            webView.loadUrl(string: "http://\(urlString)")
                } else {
                            searchTextOnGoogle(text: urlString)
                        }
        }
    }
    @IBAction func goBack(_ sender: UIButton) {
        webView.goBack()
    }
    @IBAction func goNext(_ sender: UIButton) {
        webView.goForward()
    }
    @IBAction func reloadBut(_ sender: UIButton) {
        webView.reload()
    }
    // MARK: - ActivityIndicator StartAnimate And StopAnimate
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "loading"{
                if webView.isLoading {
                    myActivityIndicator.startAnimating()
                    myActivityIndicator.isHidden = false
                } else {
                    myActivityIndicator.stopAnimating()
                }
            }
        }
    }
    // MARK: - Load Url In Webview
    extension WKWebView {
        func loadUrl(string: String) {
            if let url = URL(string: string) {
                load(URLRequest(url: url))
            }
        }
}
