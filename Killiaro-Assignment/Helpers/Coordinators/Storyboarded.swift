//
//  Storyboarded.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import UIKit

protocol Storyboarded {
    associatedtype ConcreteCoordinator
    var coordinator: ConcreteCoordinator? { get set }
    static func instantiateWithXib() -> Self
    static func instantiateWithStoryboard() -> Self
}

extension Storyboarded where Self: UIViewController {

    private static var fileName: String {
        NSStringFromClass(self)
    }

    private static var className: String {
        print(fileName.components(separatedBy: ".")[1])
        return fileName.components(separatedBy: ".")[1]
    }

    private static var storyboardName: String {
        className.deletingSuffix("ViewController")
    }

    private static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }

    static func instantiateWithStoryboard() -> Self {
        guard let vc = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Could not find View Controller named \(className)")
        }
        return vc
    }

    static func instantiateWithXib() -> Self {
        return Self.init(nibName: Self.className, bundle: nil)
    }
}

extension Storyboarded where Self: UIViewController {

    static func instantiate(coordinator: ConcreteCoordinator?) -> Self {
        var viewController = instantiateWithXib()
        viewController.coordinator = coordinator
        return viewController
    }
}

fileprivate extension String {

    /// Removes the given String from the end of the string String.
    /// If the text is not present, returns the original String intact.
    ///
    /// - Parameters:
    ///     - suffix: The text to be removed, e.g. "ViewController"
    ///
    /// - Returns:
    ///     - If suffix was found, String with the suffix removed, e.g. "MainViewController" -> "Main"
    ///     - If no suffix was found, the original string intact. e.g. "MainCoordinator" -> "MainCoordinator"
    ///
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

