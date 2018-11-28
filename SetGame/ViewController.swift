//
//  ViewController.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels(.two, .three, .three, .two)
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            print("card number = \(cardNumber)")
        }
    }
    
    func colorAndShadingForAttributes(ColorAttribute: Card.Attribute, ShadingAttribute: Card.Attribute) -> [NSAttributedString.Key: Any] {
        
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
    
    func characterForAttribute(_ attribute: Card.Attribute) -> Character {
        switch attribute {
        case .one: return "■"
        case .two: return "▲"
        case .three: return "●"
        }
    }
    
    func numberForAttribute(_ attribute: Card.Attribute) -> Int {
        switch attribute {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        }
    }
    
    func repeatCharacterWithLineBreaks(character: Character, repeats: Int) -> String {
        var string = ""
        for _ in 1..<repeats{
            string += String(character)
            string += "\n"
        }
        string += String(character)
        return string
    }
    
    func setLabels(_ attribute1: Card.Attribute, _ attribute2: Card.Attribute, _ attribute3: Card.Attribute, _ attribute4: Card.Attribute) {
        for button in cardButtons {
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = 8.0
            
            let attributes = colorAndShadingForAttributes(ColorAttribute: attribute1, ShadingAttribute: attribute2)
            let cardString = repeatCharacterWithLineBreaks(character: characterForAttribute(attribute3), repeats: numberForAttribute(attribute4))
            let cardAttributedString = NSAttributedString(string: cardString, attributes: attributes)
            
            button.setAttributedTitle(cardAttributedString, for: UIControl.State.normal)
            
            
        }
    }
    
    func titleForCard(card: Card) {
        
    }
    
    
    
}

