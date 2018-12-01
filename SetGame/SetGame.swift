//
//  SetGame.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import Foundation

struct SetGame {
    var deck: [Card]
    private(set) var selectedCards: [Card]
    
    init() {
        deck = Card.makeCards()
        selectedCards = [Card]()
    }
    
    mutating func shuffleCards() {
        cards = cards.shuffled()
    }
    
    var selectedCardsMatch {
        get() {
            return selectedCards.map({$0.isMatched = true}).reduce(true, {$0 && $1})
        }
    }
    
    mutating func select(card: Card) {
        if !selectedCards.contains(card) {
            switch selectedCards.count {
            case 0, 1: selectedCards.append(card)
            case 2:
                if card.formsASet(with: selectedCards) {
                    selectedCards.append(card)
                    selectedCards.indices.forEach({index in selectedCards[index].isMatched = true})
                } else {
                    selectedCards.append(card)
                }
            case 3: selectedCards = [Card]([card])
            default: print("ERROR: selectedCards.count has invalid value")
            }
        } else {
            switch selectedCards.count {
            case 0: break
            case 1, 2, 3: selectedCards.remove(card)
            default: print("ERROR: selectedCards.count has invalid value")
                        }
        }
    }
}
