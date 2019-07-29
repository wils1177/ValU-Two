//
//  CardViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/6/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UITableViewDelegate{
    
    var dataSource : UITableViewDataSource?
    var presentor : CardsPresentor?
    
    
    //UX Elements
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        
    }

    func setupView(){
        self.presentor!.setupTableView()
        tableView?.reloadData()
    }
    
    @IBAction func callToActionSelected(_ sender: Any) {
        
        self.presentor!.submit()
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

//extension CardViewController: UICollectionViewDataSource {
    

