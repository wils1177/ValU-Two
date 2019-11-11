//
//  DashboardTabBarController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class DashboardTabBarController: UITabBarController {
    
    var homeController : HomeCoordinator?
    var parentCoordinator : AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
    }
    
    func setUpViews(){
        self.homeController = HomeCoordinator(navigationController: UINavigationController())
        homeController!.start()
        self.viewControllers = [homeController!.navigationController]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.parentCoordinator?.loadDashboard()

    }

    func setupView(){
        
        self.viewControllers?[0].tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        self.selectedIndex = 0
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
