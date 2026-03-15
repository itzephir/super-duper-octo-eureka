//
//  NewsArticleCell.swift
//  uikit-hw5
//

import UIKit

final class NewsArticleCell: UITableViewCell {
    static let reuseId = "NewsArticleCell"

    // MARK: - UI Elements
    private let articleImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.backgroundColor = .systemGray6
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()

    private let shimmerView = ShimmerView()

    /// Tracks which URL was requested so stale completions are ignored on reuse.
    private var currentImageURL: URL?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        selectionStyle = .none

        contentView.addSubview(articleImageView)
        articleImageView.pinLeft(to: contentView, 16)
        articleImageView.pinTop(to: contentView, 12)
        articleImageView.pinBottom(to: contentView, 12, .lsOE)
        articleImageView.setWidth(80)
        articleImageView.setHeight(80)

        articleImageView.addSubview(shimmerView)
        shimmerView.pin(to: articleImageView)

        contentView.addSubview(titleLabel)
        titleLabel.pinLeft(to: articleImageView.trailingAnchor, 12)
        titleLabel.pinTop(to: contentView, 12)
        titleLabel.pinRight(to: contentView, 16)

        contentView.addSubview(descriptionLabel)
        descriptionLabel.pinLeft(to: articleImageView.trailingAnchor, 12)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 4)
        descriptionLabel.pinRight(to: contentView, 16)
        descriptionLabel.pinBottom(to: contentView, 12, .lsOE)
    }

    // MARK: - Configure
    func configure(with viewModel: ArticleCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description

        articleImageView.image = nil
        currentImageURL = viewModel.imageURL

        guard let url = viewModel.imageURL else {
            shimmerView.stopShimmer()
            shimmerView.isHidden = true
            return
        }

        shimmerView.isHidden = false
        shimmerView.startShimmer()

        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                guard self?.currentImageURL == url else { return }
                self?.shimmerView.stopShimmer()
                self?.shimmerView.isHidden = true
                self?.articleImageView.image = image
            }
        }
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        currentImageURL = nil
        shimmerView.isHidden = false
        shimmerView.stopShimmer()
    }
}
