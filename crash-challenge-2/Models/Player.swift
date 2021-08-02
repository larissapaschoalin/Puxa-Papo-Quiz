//
//  Model.swift
//  crash-challenge-2
//
//  Created by Larissa Paschoalin on 30/07/21.
//

import Foundation
import UIKit

class Player: Equatable, Hashable {
    var id = UUID()
    var name: String
    var color: UIColor
    var nameFirstLetter: String {
        return "\(name.first?.uppercased() ?? "?")"
    }

    init (name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
