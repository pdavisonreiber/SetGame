//
//  Card.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import Foundation

class Card: Equatable {
    
    enum Attribute: CaseIterable {
        case one, two, three
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.attributes == rhs.attributes
    }
    
    private(set) var attributes: [Attribute]
    var isMatched: Bool
    
    init() {
        isMatched = false
        attributes = [.one, .one, .one, .one]
    }
    
    init(withAttributes attributes: [Attribute]) {
        isMatched = false
        self.attributes = attributes
    }
    
    init(_ card: Card) {
        isMatched = false
        attributes = card.attributes
    }
    
    static func makeCards() -> [Card] {
        var cards = [Card()]
        
        func multiplyCards(using index: Int) {
            for card in cards {
                let twoCard = Card(card)
                twoCard.attributes[index] = .two
                let threeCard = Card(card)
                threeCard.attributes[index] = .three
                cards += [twoCard, threeCard]
            }
        }
        
        for index in cards.first!.attributes.indices {
            multiplyCards(using: index)
        }
        
        return cards.shuffled()
    }
}
