//
//  Coordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

protocol Coordinator:class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

