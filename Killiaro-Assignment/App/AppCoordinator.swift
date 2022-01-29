//
//  AppCoordinator.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import UIKit

final class AppCoordinator: NSObject {

    // MARK: - Variables
    let window: UIWindow?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
        super.init()

    }

    // Start of the app
    func start(animated: Bool) {
        guard let window = window else { return }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let galleryViewController = GalleryViewController.instantiate(coordinator: self)
        navigationController.pushViewController(galleryViewController, animated: true)
    }

    func navigateToDetailView(_ media: MediaModel) {
        let detailViewController = ImageViewController.instantiate(coordinator: self)
        detailViewController.imageViewModel.media = media
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

