//
//  ParserHelper.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    static func parse<T: Parceable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        
        do {
            
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                
                // init final result
                var finalResult : [T] = []
                
                
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        
                        // check foreach dictionary if parseable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                            break
                        }
                    }
                }
                
                completion(.success(finalResult))
                
            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    static func parse<T: Parceable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
          if let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8){
            if let dictionary = try JSONSerialization.jsonObject(with: utf8Data, options: .allowFragments) as? [String: AnyObject] {
                
                // init final result
                // check foreach dictionary if parseable
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
            }
          }
             else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
