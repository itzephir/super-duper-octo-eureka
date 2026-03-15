//
//  NewsAssembly.swift
//  uikit-hw5
//

import UIKit

enum NewsAssembly {
    static func build() -> UIViewController {
        let viewController = NewsViewController()
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let router = NewsRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
