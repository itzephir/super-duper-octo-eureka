//
//  NewsInteractor.swift
//  uikit-hw5
//

import Foundation

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    var presenter: NewsPresentationLogic?
    private let worker = ArticleWorker()
    private let articleManager = ArticleManager.shared

    // MARK: - NewsDataStore
    var articles: [ArticleModel] {
        get { articleManager.articles }
        set {
            articleManager.setArticles(newValue)
            presenter?.presentNews(articles: newValue)
        }
    }

    // MARK: - NewsBusinessLogic
    func loadFreshNews() {
        worker.fetchNews { [weak self] news in
            DispatchQueue.main.async {
                self?.articles = news
            }
        }
    }
}
