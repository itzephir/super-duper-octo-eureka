//
//  NewsPresenter.swift
//  uikit-hw5
//

import Foundation

final class NewsPresenter: NewsPresentationLogic {
    weak var view: NewsDisplayLogic?

    // MARK: - NewsPresentationLogic
    func presentNews(articles: [ArticleModel]) {
        let viewModels = articles.map { article in
            ArticleCellViewModel(
                title: article.title ?? "",
                description: article.announce ?? "",
                imageURL: article.img?.url
            )
        }
        view?.displayNews(viewModels)
    }

    func presentError(_ error: Error) {
        view?.displayError(error.localizedDescription)
    }
}
