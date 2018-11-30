//
//  CardButton.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 30/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import UIKit

class CardButton: UIButton {

    private var assignedCard: Card?
    
    func assignCard(_ card: Card) {
        backgroundColor = UIColor.white
        layer.cornerRadius = 8.0
        
        let attributes = colorAndShadingForAttributes(ColorAttribute: card.attributes[0], ShadingAttribute: card.attributes[1])
        let cardString = repeatCharacterWithLineBreaks(character: characterForAttribute(card.attributes[2]), repeats: numberForAttribute(card.attributes[3]))
        let cardAttributedString = NSAttributedString(string: cardString, attributes: attributes)
        
        self.setAttributedTitle(cardAttributedString, for: UIControl.State.normal)
        assignedCard = card
    }
    
    private func colorAndShadingForAttributes(ColorAttribute: Card.Attribute, ShadingAttribute: Card.Attribute) -> [NSAttributedString.Key: Any] {
        
        let color: UIColor
        
        switch ColorAttribute {
        case .one: color = .red
        case .two: color = .blue
        case .three: color = .green
        }
        
        switch ShadingAttribute {
        case .one: return [
            .foregroundColor: color
            ]
        case .two: return [
            .foregroundColor: color.withAlphaComponent(CGFloat(0.2))
            ]
        case .three: return [
            .strokeWidth: 10.0
            ]
        }
    }
    
    private func characterForAttribute(_ attribute: Card.Attribute) -> Character {
        switch attribute {
        case .one: return "■"
        case .two: return "▲"
        case .three: return "●"
        }
    }
    
    private func numberForAttribute(_ attribute: Card.Attribute) -> Int {
        switch attribute {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        }
    }
    
    private func repeatCharacterWithLineBreaks(character: Character, repeats: Int) -> String {
        var string = ""
        for _ in 1..<repeats{
            string += String(character)
            string += "\n"
        }
        string += String(character)
        return string
    }

}
