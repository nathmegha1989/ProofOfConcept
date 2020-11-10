//
//  FactListViewDataSource.swift
//  ProofOfConcept
//
//  Created by administrator on 10/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class FactListViewDataSource : GenericDataSource<FactRow>, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "factListViewCell", for: indexPath) as! FactListViewCell
        let row = self.data.value[indexPath.row]
        cell.row = row
        return cell
    }
}
