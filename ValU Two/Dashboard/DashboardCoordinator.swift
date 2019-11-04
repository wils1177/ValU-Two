//
//  DashboardCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class DasboardCoordinator: Coordinator{
    
    // Member Variables
    var childCoordinators = [Coordinator]()
    let tabBarController : UITabBarController
    weak var parent: AppCoordinator?
    
    init(tabBarController: UITabBarController){
        self.tabBarController = tabBarController
    }
    
    func start(){
        print("starting up dashboard")
        let vc1 = StartPageViewController()
        let vc2 = StartPageViewController()
        self.tabBarController.setViewControllers([vc1, vc2], animated: false)
        tabBarController.selectedIndex = 0;
    }
    

}
