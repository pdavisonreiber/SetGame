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
        setLabels()
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            print("card number = \(cardNumber)")
        }
    }
    
    func setLabels() {
        for button in cardButtons {
            button.setTitle("", for: UIControl.State.normal)
        }
    }
    
    func titleForCard(card: Card) {
        let colorsDictionary: [Card.Attribute: UIColor] = [.one: .red, .two: .blue, .three: .green]
        let shadingsDictionary 
        switch card.attributes[0] {
        case .one:
            let
        }
    }
    
    
    
}

