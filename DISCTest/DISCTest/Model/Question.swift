//
//  Question.swift
//  DISCTest
//
//  Created by Valkyrie on 02/07/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit


struct Question: Codable {
    let d: String
    let i: String
    let s: String
    let c: String
}

extension Question {
    static var all: [Question] = {
        guard let dataAsset = NSDataAsset(name: "Questions") else {
            return []
        }
        
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode([Question].self, from: dataAsset.data)
        } catch {
            return []
        }
    }()
}
