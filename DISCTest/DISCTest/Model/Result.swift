//
//  Result.swift
//  DISCTest
//
//  Created by Valkyrie on 02/07/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit

struct Result: Codable {
    static let shared: Result? = Result()
    
    let d: Info
    let i: Info
    let s: Info
    let c: Info
    
    private init?() {
        guard let dataAsset = NSDataAsset(name: "Result") else {
            return nil
        }
        
        do {
            let result = try JSONDecoder().decode(Result.self, from: dataAsset.data)
            self = result
        } catch {
            return nil
        }
    }
}

extension Result {
    struct Info: Codable {
        let title: String
        let typeDescription: String
    }
}
