//
//  Decodable+fromJSON.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 13/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
extension Decodable {
    static func fromJSON<T: Decodable>(_ fileName: String, fileExtension: String = "json") -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    static func fromJSON(_ fileName: String, fileExtension: String = "json") -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            fatalError("Error to create URL")
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            print(error)
            fatalError("Error to load json")
        }
    }
}
