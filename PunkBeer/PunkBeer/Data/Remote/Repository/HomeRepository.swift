//
//  HomeRepository.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
protocol HomeRepository {
    func fetch(page: Int, parPage: Int, completionHandler: @escaping (Result<[Beer], Error>) -> Void)
}

struct HomeRemoteRepository: HomeRepository {
    private let engine: NetworkEngine<HomeService>

    init(provider: MoyaProvider<HomeService> = ProviderBuilder<HomeService>().build()) {
        engine = NetworkEngine(provider: provider)
    }
    func fetch(page: Int, parPage: Int, completionHandler: @escaping (Result<[Beer], Error>) -> Void) {
        engine.request(target: HomeService.fetch(page: page, perPage: parPage), completion: completionHandler)
    }
    
    
}
