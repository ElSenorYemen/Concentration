//
//  Concentration.swift
//  Concentration
//
//  Created by Zak Kaid on 9/9/20.
//  Copyright © 2020 Zak Kaid. All rights reserved.
//

import Foundation

class Concentration{
    
    private(set) var cards = [Card]()
    
   
    private var indexOfOneAndOnlyFaceUpCard : Int?{
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    
    
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not valid")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                //0 or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
          }
        }
    
    
    func resetCards() {
        
        cards.removeAll()
        
    }
    
    
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            cards.shuffle()

            /*let card = Card(identifier: identifier)
            let matchingCard = Card(identifier: identifier)
            cards.append(card)
            cards.append(matchingCard) */
            
        }
        
        
        // TODO: Shuffle the cards in your homework
    }
    
}








