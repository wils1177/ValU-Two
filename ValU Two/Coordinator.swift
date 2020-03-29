//
//  Coordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator:class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    func start()
}

