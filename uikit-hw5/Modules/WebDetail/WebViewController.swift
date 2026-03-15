//
//  WebViewController.swift
//  uikit-hw5
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    // MARK: - Properties
    var url: URL?

    // MARK: - UI Elements
    private let webView = WKWebView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupWebView()
        loadArticle()
    }

    // MARK: - Setup
    private func setupWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }

    // MARK: - Load
    private func loadArticle() {
        guard let url else { return }
        webView.load(URLRequest(url: url))
    }
}
