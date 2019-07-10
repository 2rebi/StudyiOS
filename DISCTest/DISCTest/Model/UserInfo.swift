//
//  UserInfo.swift
//  DISCTest
//
//  Created by Valkyrie on 02/07/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import Foundation


struct UserInfo {
    static var shared: UserInfo = UserInfo()
    
    var name: String!
    let score = Score()
    
    var hightestScoreResult: Result.Info? {
        let hightest = max(self.score.d, self.score.i, self.score.s, self.score.c)
        
        switch hightest {
        case self.score.d:
            return Result.shared?.d
        case self.score.i:
            return Result.shared?.i
        case self.score.s:
            return Result.shared?.s
        default:
            return Result.shared?.c
        }
    }
    
    var scorePercentage: String {
        let sum = Double(self.score.d + self.score.i + self.score.s + self.score.c)
        let percentageD = Double(self.score.d) / sum * 100
        let percentageI = Double(self.score.i) / sum * 100
        let percentageS = Double(self.score.s) / sum * 100
        let percentageC = Double(self.score.c) / sum * 100
        
        return String(format: "D : %01f%%, I : %01f%%, S : %01f%%, C : %01f%%", percentageD, percentageI, percentageS, percentageC)
    }
}


extension UserInfo {
    class Score {
        var d = 0
        var i = 0
        var s = 0
        var c = 0
    }
    
    mutating func reset() {
        self.score.d = 0
        self.score.i = 0
        self.score.s = 0
        self.score.c = 0
        self.name = nil
    }
    
    enum ScoreType {
        case d, i, s, c
    }
}
