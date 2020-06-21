//
//  PublicTokenGenerationService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/26/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

struct PublicTokenGenrationServiceResult{
    var publicToken : String
    var itemId: String
}

class PublicTokenGenerationService {
    
    var completion : (Result<PublicTokenGenrationServiceResult, Error>) -> ()
    var itemId: String
    
    init(completion : @escaping (Result<PublicTokenGenrationServiceResult, Error>) -> (), itemId: String){
        self.completion = completion
        self.itemId = itemId
    }
    
    // Kick off network request to create a new public token
    func getPublicToken(){
        let plaid = PlaidConnection()
        
        do{
            try plaid.getPublicToken(itemId: self.itemId, completion: self.publicTokenFinished(result:))
        }
        catch{
            //TODO: Enter Error State
            self.completion(Result.failure(PlaidConnectionError.BadRequest))
        }
        
    }
    
    // Handle the network response post network request
    func publicTokenFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                //TODO handle error
                print(error)
                self.completion(Result.failure(PlaidConnectionError.BadRequest))
            case .success(let dataResult):
                self.proccessPublicToken(result: dataResult)
                print("Gathered Public Token")
                
            }
        }
        
    }
    
    //Proccess a successfull network response for public token generation
    func proccessPublicToken(result: Data){
        do{
            let publicToken = try PlaidProccessor.proccessPublicToken(response: result)
            let result = PublicTokenGenrationServiceResult(publicToken: publicToken, itemId: self.itemId)
            self.completion(.success(result))
        }
        catch{
            self.completion(Result.failure(PlaidConnectionError.BadRequest))
        }
        
    }
    
}
