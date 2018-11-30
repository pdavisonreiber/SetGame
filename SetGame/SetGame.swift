//
//  SetGame.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import Foundation

struct SetGame {
    var cards: [Card]
    private(set) var selectedCards: [Card]
    
    init() {
        cards = Card.makeCards().shuffled()
        selectedCards = [Card]()
    }
    
    mutating func shuffleCards() {
        cards = cards.shuffled()
    }
    
    mutating func select(card: Card) {
        switch selectedCards.count {
        case 0,1:
            selectedCards.append(card)
        case 2:
            if card.formsASet(with: selectedCards) {
                selectedCards.append(card)
                selectedCards.indices.forEach({index in selectedCards[index].isMatched = true})
            } else {
                selectedCards.append(card)
            }
        case 3:
            selectedCards = [Card]([card])
        default:
            print("ERROR: selectedCards.count has invalid value")
        }
    }
}
