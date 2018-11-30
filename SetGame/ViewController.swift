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
        cardButtons = cardButtons.shuffled()
        assignInitialCardsToCardButtons()
    }

    @IBOutlet var cardButtons: [CardButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if cardButtonAssignments.keys.contains(sender) {
            //selectButton(sender)
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var moreCardsButton: UIButton!
    
    @IBAction func touchMoreCardsButton() {
    }
    
    @IBAction func touchNewGameButton() {
        scoreLabel.text = "Score: 0"
        game.shuffleCards()
    }
    
    func assignInitialCardsToCardButtons() {
        for index in 1...12 {
            assignCardToButton(card: game.cards[index], button: shuffledCardButtons[index])
        }
    }
    
    
}

