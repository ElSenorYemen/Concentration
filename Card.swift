//
//  Card.swift
//  Concentration
//
//  Created by Zak Kaid on 9/9/20.
//  Copyright © 2020 Zak Kaid. All rights reserved.
//

import Foundation

struct Card: Hashable{
    
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}


extension Card {//hashable and equatable
    var hashValue: Int {
        return identifier
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
