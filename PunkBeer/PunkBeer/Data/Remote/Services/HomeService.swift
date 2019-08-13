//
//  HomeService.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya

enum HomeService {
    case fetch(page: Int, perPage: Int?)
}
extension HomeService: Service{
    var baseURL: URL {
        return NetworkConstants.Network.URLs.base
    }
    
    var path: String {
        return "beers"
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .fetch(let page, let perPage):
            let perPage = perPage ?? 10
            return .requestParameters(parameters: ["page": page, "per_page": perPage], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var authorizationType: AuthorizationType {
        return .none
    }
}
