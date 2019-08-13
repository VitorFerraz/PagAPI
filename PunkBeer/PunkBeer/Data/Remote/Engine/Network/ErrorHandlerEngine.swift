//
//  ErrorHandlerEngine.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class ErrorHandlerEngine<Target: Service>: NetworkRequestEngine {
    
    private var provider: MoyaProvider<Target>
    private var engine: NetworkRequestEngine
    init(provider: MoyaProvider<Target>, engine: NetworkRequestEngine) {
        self.provider = provider
        self.engine = engine
    }
    
    func request<T>(target: TargetType, completion: @escaping (Result<[T], Error>) -> Void) where T : ModelInterface {
        guard let target = target as? Target else {
            return completion(.failure(NetworkError.unknown))
        }
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? (error as NSError).code
                switch statusCode {
                case 500:
                    return completion(.failure(NetworkError.serverError))
                case 404:
                    return completion(.failure(NetworkError.custom("Rota não encontrada")))
                case -1001:
                    return completion(.failure(NetworkError.noConnection))
                default:
                    return completion(.failure(NetworkError.unknown))
                }
            case .success:
                return self.engine.request(target: target, completion: completion)
            }
        }
        
    }
    
}
