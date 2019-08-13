//
//  NetworkError.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
enum NetworkError: Error {
    case custom(String)
    case unknown
    case noConnection
    case serverError
    case parserError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .custom(let msg):
            return msg
        case .noConnection:
            return "Sem conexão com a internet."
        case .serverError:
            return "Erro no servidor."
        case .parserError:
            return "Erro ao parsear o retorno da API."
        case .unknown:
            return "Ocorreu um erro inesperado"
        }
    }
}
