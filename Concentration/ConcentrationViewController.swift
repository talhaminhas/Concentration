//
//  ViewController.swift
//  Concentration
//
//  Created by Minhax on 08/02/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    private lazy var game = Concentration(noOfPairsOfCards: noOfPairsOfCards)
    var noOfPairsOfCards:Int{
        return cardButtons.count/2
    }
    lazy var attributes:[NSAttributedString.Key:Any]=[
            .strokeWidth : 5.0,
            .strokeColor : game.themes[theme%6].labels
    ]
    private func updateFlipCountLabel(){
        var attributedString=NSAttributedString(string: "Flips : \(game.flipCount)",attributes: attributes)
        flipCountLabel.attributedText=attributedString
        
        attributedString=NSAttributedString(string: "Score : \(game.score)",attributes: attributes)
        scoreLabel.attributedText=attributedString
        
    }
    var theme = 0
    private var emojiChoices = "😅😂🤪🥶😘🥺😅😂🤪🥶😘🥺"
    var Theme: String? {
        didSet{
            emojiChoices = Theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    @IBOutlet var background: UIView!
    private lazy var emojis = game.themes[0].emoji
    @IBOutlet weak var themeLabel: UILabel!{
        didSet{
            let attributedString=NSAttributedString(string: "\(game.themes[theme%6].name)",attributes: attributes)
            themeLabel.attributedText=attributedString
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!{
        didSet{
            let attributedString=NSAttributedString(string: "Score : \(game.score)",attributes: attributes)
            scoreLabel.attributedText=attributedString
        }
    }
    @IBAction func newGame(_ sender: UIButton) {
        sender.shake()
        background.flash1()
        theme+=1
        attributes=[
                .strokeWidth : 7.0,
                .strokeColor : game.themes[theme%6].labels
        ]
        let attributedString=NSAttributedString(string: "\(game.themes[theme%6].name)",attributes: attributes)
        themeLabel.attributedText=attributedString
        game = Concentration(noOfPairsOfCards: noOfPairsOfCards)
        emojis = game.themes[theme%6].emoji
        background.backgroundColor = game.themes[theme%6].background
        updateViewFromModel()
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            let attributedString=NSAttributedString(string: "Flips : \(game.flipCount)",attributes: attributes)
            flipCountLabel.attributedText=attributedString
        }
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        sender.pulsate()
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
        
    }
    private func updateViewFromModel(){
        if(cardButtons != nil){
            updateFlipCountLabel()
            for index in cardButtons.indices{
                let button = cardButtons[index]
                button.layer.cornerRadius = 20
                let card = game.cards[index]
                if card.isFacedUp{
                    button.setTitle(emoji(for:card),for:UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 0)
                }else{
                    button.setTitle("",for:UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 0):game.themes[theme%6].card
                }
            }
        }
    }
    
    
    private var emoji = [Card:String]()
    private func emoji (for card:Card)->String{
        if emoji[card] == nil,emojiChoices.count>0{// , means and
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex,offsetBy: Int(arc4random_uniform(UInt32(emojiChoices.count))))
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        /*if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        }else{
            return"?"
        }folowing line means this code*/
        return emoji[card] ?? "?"
    }
    
}


