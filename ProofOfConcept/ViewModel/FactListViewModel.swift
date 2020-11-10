//
//  FactListViewModel.swift
//  ProofOfConcept
//
//  Created by administrator on 10/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import UIKit

struct FactListViewModel {
    
    weak var dataSource : GenericDataSource<FactRow>?
    weak var service: FactServiceProtocol?
    var navigationItem: UINavigationItem?
    var refreshControl:UIRefreshControl?

    var onErrorHandling : ((ErrorResult?) -> Void)?
        
  init(service: FactServiceProtocol = FactService.shared, dataSource : GenericDataSource<FactRow>?) {
      self.dataSource = dataSource
      self.service = service
    }

    func fetchFacts() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchFacts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fact) :
                  self.refreshControl?.endRefreshing()
                  self.navigationItem?.title = fact.title
                  self.dataSource?.data.value = fact.rows ?? []
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
