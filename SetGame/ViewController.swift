        //
        //  ViewController.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import UIKit
        
extension Dictionary where Value: Equatable {
    func key(forValue value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
}
        
class ViewController: UIViewController {

    private var game = SetGame()
    private var cardAssignments: [UIButton: Card] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...4 {
            dealThreeCards()
        }
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let card = cardAssignments[sender] {
            game.select(card: card)
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var moreCardsButton: UIButton!
    
    @IBAction func touchMoreCardsButton() {
        dealThreeCards()
    }
    
    @IBAction func touchNewGameButton() {
        scoreLabel.text = "Score: 0"
        game = SetGame()
    }
    
    private func updateViewFromModel() {
        for button in cardButtons {
            if let card = cardAssignments[button] {
                if game.selectedCards.contains(card) {
                    showSelection(on: button)
                    if card.isMatched {
                        showMatchedHighlight(on: button)
                    }
                } else {
                    removeSelection(on: button)
                    if card.isMatched { removeAssigned(card: card, from: button) }
                }
            }
        }
        
        if game.deck.count > 0 && blankCardButtons.count > 0 {
            enableMoreCardsButton()
        }
    }
    
    private var blankCardButtons: [UIButton] {
        get {
            return cardButtons.filter({!cardAssignments.keys.contains($0)})
        }
    }
    
    private func dealThreeCards() {
        if game.deck.count == 0 || blankCardButtons.count < 3 {
            disableMoreCardsButton()
        } else if game.selectedCardsMatch {
            for card in game.selectedCards {
                if let button = cardAssignments.key(forValue: card) {
                    removeAssigned(card: card, from: button)
                }
            }
            
        } else {
            for button in blankCardButtons[0...2] {
                assign(card: game.deck.removeFirst(), to: button)
            }
        }
    }
    
    private func disableMoreCardsButton() {
        moreCardsButton.backgroundColor = moreCardsButton.backgroundColor?.withAlphaComponent(0.25)
    }
    
    private func enableMoreCardsButton() {
        moreCardsButton.backgroundColor = moreCardsButton.backgroundColor?.withAlphaComponent(1)
    }
    
    func assign(card: Card, to button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 8.0
        
        let attributes = colorAndShadingForAttributes(ColorAttribute: card.attributes[0], ShadingAttribute: card.attributes[1])
        let cardString = repeatCharacterWithLineBreaks(character: characterForAttribute(card.attributes[2]), repeats: numberForAttribute(card.attributes[3]))
        let cardAttributedString = NSAttributedString(string: cardString, attributes: attributes)
        
        button.setAttributedTitle(cardAttributedString, for: UIControl.State.normal)
        cardAssignments[button] = card
    }
    
    func removeAssigned(card: Card, from button: UIButton) {
        cardAssignments[button] = nil
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1).cgColor
        button.layer.borderWidth = 0
    }
    
    func showSelection(on button: UIButton) {
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.red.cgColor
        
    }
    
    func removeSelection(on button: UIButton) {
        button.layer.borderWidth = 0
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1).cgColor
    }
    
    func showMatchedHighlight(on button: UIButton) {
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.green.cgColor
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

