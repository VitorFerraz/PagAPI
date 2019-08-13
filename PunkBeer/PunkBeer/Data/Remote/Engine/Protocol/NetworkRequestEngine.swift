//
//  NetworkRequestEngine.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya

protocol NetworkRequestEngine {
    func request<T: ModelInterface>(target: TargetType, completion: @escaping(Result<[T],Error>) -> Void)
}

