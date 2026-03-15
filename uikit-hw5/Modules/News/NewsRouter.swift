//
//  NewsRouter.swift
//  uikit-hw5
//

import UIKit

final class NewsRouter: NewsRoutingLogic {
    weak var viewController: UIViewController?

    func navigateToArticle(with url: URL) {
        let webVC = WebViewController()
        webVC.url = url
        viewController?.navigationController?.pushViewController(webVC, animated: true)
    }

    func shareArticle(url: URL) {
        let encodedURL = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let vkURL = URL(string: "https://vk.com/share.php?url=\(encodedURL)") else { return }
        UIApplication.shared.open(vkURL)
    }
}
