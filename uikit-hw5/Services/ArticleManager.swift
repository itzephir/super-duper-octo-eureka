//
//  ArticleManager.swift
//  uikit-hw5
//

import Foundation

final class ArticleManager {
    static let shared = ArticleManager()

    private(set) var articles: [ArticleModel] = []
    private let decoder = JSONDecoder()

    private init() {}

    func setArticles(_ articles: [ArticleModel]) {
        self.articles = articles
    }

    // MARK: - URL Builder
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }

    // MARK: - Fetch news
    func fetchNews(
        rubricId: Int = 4,
        pageIndex: Int = 1,
        completion: @escaping @Sendable ([ArticleModel]) -> Void
    ) {
        guard let url = getURL(rubricId, pageIndex) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error {
                print(error)
                completion([])
                return
            }

            guard let self, let data else {
                completion([])
                return
            }

            DispatchQueue.main.async { [weak self] in
                if var newsPage = try? self?.decoder.decode(NewsPage.self, from: data) {
                    newsPage.passTheRequestId()
                    let news = newsPage.news ?? []
                    self?.articles = news
                    completion(news)
                } else {
                    completion([])
                }
            }
        }.resume()
    }
}
