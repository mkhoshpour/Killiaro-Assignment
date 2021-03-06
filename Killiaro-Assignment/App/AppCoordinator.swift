//
//  AppCoordinator.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    // Since AppCoordinator is top of all coordinators of our app, it has no parent and is nil.
    var parentCoordinator: Coordinator?
    // ChildCoordinators of AppCoordinator
    var childCoordinators: [Coordinator] = []

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
        let detailViewController = ImagePlayerViewController.instantiate(coordinator: self)
        detailViewController.imageViewModel.media = media
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}
