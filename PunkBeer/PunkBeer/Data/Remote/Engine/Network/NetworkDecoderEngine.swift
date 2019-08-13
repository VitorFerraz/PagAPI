//
//  NetworkDecoderEngine.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya

final class NetworkDecoderEngine<Target: Service>: NetworkRequestEngine {
    
    private var provider: MoyaProvider<Target>
    
    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }
    
    func request<T>(target: TargetType, completion: @escaping (Result<[T], Error>) -> Void) where T : ModelInterface {
        guard let target = target as? Target else {
            return completion(.failure(NetworkError.unknown))
        }
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let value):
                if value.data.isEmpty {
                    return completion(.success([]))
                }
                do {
                    let obj = try target.decoder.decode([T].self, from: value.data)
                    return completion(.success(obj))

                } catch {
                    print(error)
                    return completion(.failure(NetworkError.parserError))
                }
            }
        }
        
    }
    
    func update(token: String) {
        let authPlugin = AccessTokenPlugin { () -> String in
            return token
        }
        provider = ProviderBuilder().build(authPlugin)
    }
}
