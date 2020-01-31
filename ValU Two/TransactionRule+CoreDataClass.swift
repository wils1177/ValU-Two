//
//  TransactionRule+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 1/29/20.
//
//

import Foundation
import CoreData

@objc(TransactionRule)
public class TransactionRule: NSManagedObject {
    
    
    convenience init(name : String, amountOverride: Float? = nil, categoryOverride: [Category]? = nil,  context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "TransactionRule", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.amountOverride = 0.0
        if categoryOverride != nil{
            self.categoriesOverride?.addingObjects(from: categoryOverride!)
        }
        
    }
    

}
