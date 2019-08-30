//
//  Routing.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import UIKit

protocol Routing: class {
    var topViewController: UIViewController { get set }
    func present(_ viewController: UIViewController, completion: VoidClosure?)
    func dismiss(completion: VoidClosure?)
}

extension Routing {
    func present(_ viewController: UIViewController, completion: VoidClosure? = nil) {
        topViewController.present(viewController, animated: true, completion: completion)
    }
    
    func dismiss(completion: VoidClosure? = nil) {
        topViewController.dismiss(animated: true, completion: completion)
    }
}

protocol NavigationRouting: Routing {
    var navigationController: UINavigationController { get }
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func setRoot(_ viewController: UIViewController, animated: Bool)
}

extension NavigationRouting {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
        topViewController = viewController
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: true)
        topViewController = navigationController.topViewController ?? navigationController
    }
    
    func setRoot(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([viewController], animated: animated)
    }
}
