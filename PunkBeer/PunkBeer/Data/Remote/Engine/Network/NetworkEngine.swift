//
//  NetworkEngine.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class NetworkEngine<Target: Service> {
    private var engine: NetworkRequestEngine
    
    init(provider: MoyaProvider<Target>) {
        engine = NetworkEngineBuilder(provider: provider).withErrorHandler().withReachability().build()
    }
}
extension NetworkEngine: NetworkRequestEngine {
    func request<T>(target: TargetType, completion: @escaping (Result<[T], Error>) -> Void) where T : ModelInterface {
        engine.request(target: target, completion: completion)
    }
}
