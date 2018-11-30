//
//  ViewController.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var game = SetGame()
    private var cardButtonAssignments: [UIButton: Card] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialCardButtons()
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if cardButtonAssignments.keys.contains(sender) {
            //3selectButton(sender)
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var moreCardsButton: UIButton!
    
    @IBAction func touchMoreCardsButton() {
    }
    
    @IBAction func touchNewGameButton() {
        scoreLabel.text = "Score: 0"
        cardButtonAssignments = [:]
        game.shuffleCards()
        setInitialCardButtons()
    }
    
    
//    func selectButton(_ button: UIButton) {
//        if button.strok
//    }
    
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
    
    func assignCardToButton(card: Card, button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 8.0
        
        let attributes = colorAndShadingForAttributes(ColorAttribute: card.attributes[0], ShadingAttribute: card.attributes[1])
        let cardString = repeatCharacterWithLineBreaks(character: characterForAttribute(card.attributes[2]), repeats: numberForAttribute(card.attributes[3]))
        let cardAttributedString = NSAttributedString(string: cardString, attributes: attributes)
        
        button.setAttributedTitle(cardAttributedString, for: UIControl.State.normal)
        
        cardButtonAssignments[button] = card
    }
    
    func setInitialCardButtons() {
        let shuffledCardButtons = cardButtons.shuffled()
        for index in 1...12 {
            assignCardToButton(card: game.cards[index], button: shuffledCardButtons[index])
        }
    }
    
}

