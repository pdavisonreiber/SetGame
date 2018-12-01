        //
        //  ViewController.swift
//  SetGame
//
//  Created by Peter Davison-Reiber on 24/11/2018.
//  Copyright © 2018 Peter Davison-Reiber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private weak var game = SetGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardButtons = cardButtons.shuffled()
    }

    @IBOutlet var cardButtons: [CardButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let card = sender.assignedCard {
            game.select(card: card)
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var moreCardsButton: UIButton!
    
    @IBAction func touchMoreCardsButton() {
        for button in cardButtons{
            
        }
    }
    
    @IBAction func touchNewGameButton() {
        scoreLabel.text = "Score: 0"
        game = SetGame()
    }
    
    private func updateViewFromModel() {
        for button in cardButtons {
            if let card = button.assignedCard {
                if game.selectedCards.contains(card) {
                    button.showSelection()
                    if card.isMatched { button.showMatched() }
                } else {
                    button.removeSelection()
                    if card.isMatched { button.removeAssignedCard() }
                }
            }
        }
    }
    
    private var blankCardButtons {
        get() {
            return cardButtons.filter({ $0.assignedCard = nil})
        }
    }
    
    private func dealThreeCards() {
        if deck.count = 0 || blankCardButtons.count = 0 {
            disableMoreCardsButton()
        } else if game.selectedCardsMatch {
            for card in game.selectedCards {
                if let index = cardButtons.index(where: {$0.assignedCard = card}) {
                    cardButtons[index].assignCard(deck.removeFirst())
                }
            }
            
        } else {
            for button in blankCardButtons[0...2] {
                button.assignCard(deck.removeFirst())
            }
        }
    }
    
}

