//
//  Compatibility.swift
//  crash-challenge-2
//
//  Created by Larissa Paschoalin on 02/08/21.
//

import UIKit

class Compatibility: NSObject {
    var player1: Player
    var player2: Player
    var options: [Options] = []
    var totalOptions: Int
    var percentage: Int {
        return Int((Double(options.count) / Double(totalOptions)) * 100)
    }
    
    init(player1: Player, player2: Player, totalOptions: Int) {
        self.player1 = player1
        self.player2 = player2
        self.totalOptions = totalOptions
    }
    
    static var all: [Compatibility] = []
    
    static func startCompatibilities(players: [Player], totalOptions: Int) -> [Compatibility] {
        var compatibilities: [Compatibility] = []
        for i in 0..<players.count {
            for j in (i+1)..<players.count {
                compatibilities.append(Compatibility(player1: players[i], player2: players[j], totalOptions: totalOptions))
            }
        }
        return compatibilities
    }
    
    static func assignCompatibility(players: [Player], option: Options) {
        if players.count <= 1 {
            return
        }
        for i in 0..<players.count {
            for j in (i+1)..<players.count {
                if let index = Compatibility.all.firstIndex(where: {$0.player1 == players[i] && $0.player2 == players[j]}) ?? Compatibility.all.firstIndex(where: {$0.player1 == players[j] && $0.player2 == players[i]}) {
                    Compatibility.all[index].options.append(option)
                }
            }
        }
    }
}
