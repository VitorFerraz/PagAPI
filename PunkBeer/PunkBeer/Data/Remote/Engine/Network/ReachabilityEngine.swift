//
//  ReachabilityEngine.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Reachability
import Moya

final class ReachabilityEngine: NetworkRequestEngine {
    
    private let engine: NetworkRequestEngine
    private let reachability: Reachability?
    init(reachability: Reachability? = Reachability(), engine: NetworkRequestEngine) {
        self.reachability = reachability
        self.engine = engine
    }
    
    func request<T>(target: TargetType, completion: @escaping (Result<[T], Error>) -> Void) where T : ModelInterface {
        if let connection = reachability?.connection, connection == .none {
            return completion(.failure(NetworkError.noConnection))
        }
        return engine.request(target: target, completion: completion)
    }
}
