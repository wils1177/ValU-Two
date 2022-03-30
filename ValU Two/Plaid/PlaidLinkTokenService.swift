//
//  PlaidLinkTokenService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/19/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import Foundation

struct PlaidLinkTokenResult{
    var linkToken : String
}

class PlaidLinkTokenService{
    
    var completion : (Result<PlaidLinkTokenResult, Error>) -> ()
    
    init(completion : @escaping (Result<PlaidLinkTokenResult, Error>) -> ()){
        self.completion = completion
    }
    
    func getLinkToken(){
        let plaid = PlaidConnection()
        
        do{
            try plaid.getLinkToken(completion: self.linkTokenRequestFinished(result:))
        }
        catch{
            self.completion(Result.failure(PlaidConnectionError.BadRequest))
        }
    }
    
    func linkTokenRequestFinished(result: Result<Data, Error>){
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                //TODO handle error
                print(error)
                self.completion(Result.failure(PlaidConnectionError.BadRequest))
            case .success(let dataResult):
                self.processLinkToken(result: dataResult)
                print("Gathered Public Token")
                
            }
        }
        
    }
    
    func processLinkToken(result: Data){
        
        let decoder = JSONDecoder()
        do {
            let parsedResponse = try decoder.decode(LinkTokenResponse.self, from: result)
            let final_result = PlaidLinkTokenResult(linkToken: parsedResponse.link_token)
            self.completion(.success(final_result))
        }
        catch{
            self.completion(Result.failure(PlaidConnectionError.BadRequest))
        }
        
    }
    
}
