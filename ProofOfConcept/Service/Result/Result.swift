//
//  Result.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
