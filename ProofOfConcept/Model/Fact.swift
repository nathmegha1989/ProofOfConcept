//
//  Fact.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation

struct FactRow {
  var title: String?
  var description: String?
  var imageHref: String?
}

struct Fact {
    var title: String?
    var rows: [FactRow]?
}

extension Fact : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Fact, ErrorResult> {
        if let title = dictionary["title"] as? String,
          let rows = dictionary["rows"] as? NSArray as? [[String:Any]]{
          var facts : [FactRow] = []
          for item in rows {
            if let rowTitle = item["title"],
              let description = item["description"],
              let imageHref = item["imageHref"] {
              let factRow = FactRow(title: rowTitle as? String, description: description as? String, imageHref: imageHref as? String)
              facts.append(factRow)
            }
          }
            let fact = Fact(title: title, rows: facts)
            return Result.success(fact)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
