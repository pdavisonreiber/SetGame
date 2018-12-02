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
        deck = deck.shuffled()
    }
    
    var selectedCardsMatch: Bool {
        get {
            return selectedCards.count == 3 && selectedCards.map({$0.isMatched == true}).reduce(true, {x, y in x && y})
        }
    }
    
    mutating func select(card: Card) {
        if !selectedCards.contains(card) {
            switch selectedCards.count {
            case 0, 1: selectedCards.append(card)
            case 2:
                selectedCards.append(card)
                if selectedCards.formASet() {
                    selectedCards.indices.forEach({ selectedCards[$0].isMatched = true})
                }
            case 3: selectedCards = [Card]([card])
            default: print("ERROR: selectedCards.count has invalid value")
            }
        } else if card.isMatched {
            deselectAllCards()
        } else {
            switch selectedCards.count {
            case 0: break
            case 1, 2, 3: selectedCards.remove(at: selectedCards.index(of: card)!)
            default: print("ERROR: selectedCards.count has invalid value")
                        }
        }
    }
    
    mutating func deselectAllCards() {
        selectedCards = [Card]()
    }
    
}

extension Array where Element: Card {
    func haveTheSameAttributeAtIndex(_ index: Int) -> Bool {
        assert(self.count == 3)
        return self[0].attributes[index] == self[1].attributes[index] && self[1].attributes[index] == self[2].attributes[index]
    }
    
    func haveDistinctAttributesAtIndex(_ index: Int) -> Bool {
        assert(self.count == 3)
        return self[0].attributes[index] != self[1].attributes[index] && self[1].attributes[index] != self[2].attributes[index] && self[0].attributes[index] != self[2].attributes[index]
    }
    
    func formASet() -> Bool {
        var matchAtIndex = [Bool]()
        for index in self[0].attributes.indices {
            matchAtIndex.append(self.haveTheSameAttributeAtIndex(index) || self.haveDistinctAttributesAtIndex(index))
        }
        return matchAtIndex.reduce(true, {$0 && $1})
    }
}
