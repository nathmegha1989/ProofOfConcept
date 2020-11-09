//
//  RequestRouter.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
class RequestRouter {
      enum Method: String {
      case GET
  }
  
  static func request(method: Method, url: URL) -> URLRequest {
      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      return request
  }

}
