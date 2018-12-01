//
//  Card.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import Foundation

struct Card {
    
    enum Attribute: CaseIterable {
        case one, two, three
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
    
    mutating func match() {
        isMatched = true
    }
    
    private func sharesAttribute(at index: Int, with card: Card) -> Bool {
        return attributes[index] == card.attributes[index]
    }
    private func sharesAttribute(at index: Int, with cards: [Card]) -> Bool {
        return cards.map({
            card in card.sharesAttribute(at: index, with: self)
        }).reduce(true, {x, y in x && y})
    }
    
    private func formsAMutuallyDistinctSet(with cards: [Card], withRespectToAttributeAtIndex index: Int) -> Bool {
        if cards.isEmpty{ return false }
        let selfIsDistinctFromEachOfTheOtherCards = cards.map({
            card in !self.sharesAttribute(at: index, with: card)
        }).reduce(true, {x, y in x && y})
        let nextCard = cards[0]
        let otherCardsWithoutNextCard = Array(cards[1...])
        let otherCardsAreDifferentFromEachOther = nextCard.formsAMutuallyDistinctSet(with: otherCardsWithoutNextCard, withRespectToAttributeAtIndex: index)
        return selfIsDistinctFromEachOfTheOtherCards && otherCardsAreDifferentFromEachOther
    }
    
    func formsASet(with cards: [Card]) -> Bool {
        if cards.isEmpty { return false }
        
        assert(cards.map({
            card in self.attributes.count == card.attributes.count
        }).reduce(true, {x, y in x && y}), "Card.formsASetWith(\(cards)): number of attributes does not match.")
        
        return attributes.indices.map({
            index in self.sharesAttribute(at: index, with: cards) || self.formsAMutuallyDistinctSet(with: cards, withRespectToAttributeAtIndex: index)
        }).reduce(true, {x, y in x && y})
        
    }
    
    static func makeCards() -> [Card] {
        var cards = [Card()]
        
        func multiplyCards(using index: Int) {
            for card in cards {
                var twoCard = card
                twoCard.attributes[index] = .two
                var threeCard = card
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
