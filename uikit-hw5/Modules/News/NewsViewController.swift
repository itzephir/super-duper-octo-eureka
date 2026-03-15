//
//  NewsViewController.swift
//  uikit-hw5
//

import UIKit

final class NewsViewController: UIViewController {
    var interactor: (NewsBusinessLogic & NewsDataStore)?
    var router: NewsRoutingLogic?

    private var articles: [ArticleCellViewModel] = []

    // MARK: - UI Elements
    private let tableView = UITableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        setupTableView()
        interactor?.loadFreshNews()
    }

    // MARK: - Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsArticleCell.self, forCellReuseIdentifier: NewsArticleCell.reuseId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 104
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - NewsDisplayLogic
extension NewsViewController: NewsDisplayLogic {
    func displayNews(_ viewModels: [ArticleCellViewModel]) {
        self.articles = viewModels
        tableView.reloadData()
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsArticleCell.reuseId,
            for: indexPath
        ) as? NewsArticleCell else {
            return UITableViewCell()
        }
        cell.configure(with: articles[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article = interactor?.articles[indexPath.row],
              let url = article.articleUrl else { return }
        router?.navigateToArticle(with: url)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Share") { [weak self] _, _, completion in
            guard let article = self?.interactor?.articles[indexPath.row],
                  let url = article.articleUrl else {
                completion(false)
                return
            }
            self?.router?.shareArticle(url: url)
            completion(true)
        }
        shareAction.backgroundColor = .systemBlue
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
}
