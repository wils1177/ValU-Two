//
//  PlaidParsing.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/28/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation


struct TokenExchangeResponse : Codable {
    let accessToken : String
    
    enum CodingKeys : String, CodingKey {
        case accessToken =  "access_token"
    }
}


struct TransactionsResponse : Codable{
    
    let trasactions : [TransactionJSON]?
    let accounts : [AccountJSON]
    let item : ItemJSON
    let request_id : String?
    let total_transactions : Int?
    
    enum CodingKeys : String, CodingKey {
        case trasactions =  "transactions"
        case item = "item"
        case request_id = "request_id"
        case total_transactions = "total_transactions"
        case accounts = "accounts"
    }

}

struct AccountsResponse : Codable{
    let accounts : [AccountJSON]
    let item : ItemJSON
    
    enum CodingKeys : String, CodingKey {
        case accounts = "accounts"
        case item = "item"
    }
    
}


struct TransactionJSON : Codable {
    var accountId : String
    var amount : Double
    var date : String
    var name : String
    var location : LocationJSON
    var pending : Bool
    var transactionId : String
    var plaidCategories : [String]
    
    enum CodingKeys : String, CodingKey {
        case accountId  = "account_id"
        case amount = "amount"
        case date = "date"
        case name = "name"
        case location = "location"
        case pending = "pending"
        case transactionId = "transaction_id"
        case plaidCategories = "category"
        
    }
    
}

struct AccountJSON : Codable {
    
    var accountId : String
    var balances : BalanceJSON
    var mask : String
    var name : String
    var officialName : String?
    var type : String
    var subType : String
    
    enum CodingKeys : String, CodingKey {
        case accountId = "account_id"
        case balances = "balances"
        case mask = "mask"
        case name = "name"
        case officialName = "official_name"
        case type = "type"
        case subType = "subtype"
        
    }
    
}

struct BalanceJSON : Codable {
    var available : Double?
    var current : Double
    var limit : Double?
    
    enum CodingKeys : String, CodingKey {
        case available = "available"
        case current = "current"
        case limit = "limit"
    }
    
}

struct ItemJSON: Codable {
    
    var billedProducts : [String]
    var error : String?
    var institutionId : String
    var itemId : String
    
    enum CodingKeys : String, CodingKey {
        case billedProducts = "billed_products"
        case error = "error"
        case institutionId = "institution_id"
        case itemId = "item_id"
    }
    
}



struct LocationJSON : Codable {
    var address : String?
    var city :  String?
    var country : String?
    var lat : String?
    var lon : String?
    var postalCode : String?
    var region : String?
    var storeNumber : String?
    
    enum CodingKeys : String, CodingKey {
        case address =  "address"
        case city = "city"
        case country = "country"
        case lat = "lat"
        case lon = "lon"
        case postalCode = "postal_code"
        case region  = "region"
        case storeNumber = "store_number"
    }
}



