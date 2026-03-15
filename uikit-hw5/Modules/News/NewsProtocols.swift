//
//  NewsProtocols.swift
//  uikit-hw5
//

import UIKit

// MARK: - View Model
struct ArticleCellViewModel {
    let title: String
    let description: String
    let imageURL: URL?
}

// MARK: - NewsBusinessLogic
protocol NewsBusinessLogic: AnyObject {
    func loadFreshNews()
}

// MARK: - NewsDataStore
protocol NewsDataStore: AnyObject {
    var articles: [ArticleModel] { get }
}

// MARK: - NewsPresentationLogic
protocol NewsPresentationLogic: AnyObject {
    func presentNews(articles: [ArticleModel])
    func presentError(_ error: Error)
}

// MARK: - NewsDisplayLogic
protocol NewsDisplayLogic: AnyObject {
    func displayNews(_ viewModels: [ArticleCellViewModel])
    func displayError(_ message: String)
}

// MARK: - NewsRoutingLogic
protocol NewsRoutingLogic: AnyObject {
    func navigateToArticle(with url: URL)
    func shareArticle(url: URL)
}
