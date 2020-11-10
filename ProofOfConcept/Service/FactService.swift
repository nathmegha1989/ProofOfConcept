//
//  FactService.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
protocol FactServiceProtocol : class {
    func fetchFacts(_ completion: @escaping ((Result<Fact, ErrorResult>) -> Void))

}

final class FactService : RequestHandler, FactServiceProtocol {
    
    static let shared = FactService()
    
    let endpoint = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var task : URLSessionTask?
    
    func fetchFacts(_ completion: @escaping ((Result<Fact, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchFacts()
        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchFacts() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
