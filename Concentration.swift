//
//  Concentration.swift
//  Concentration
//
//  Created by Minhax on 08/02/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import Foundation

struct Concentration{
    
    private (set) var cards = [Card]()
    private (set) var themes = [Theme]()
    private (set) var score = 0
    private (set) var flipCount = 0
    private var indexOfOneCardFaceUp : Int?{//computed property
        get{
            return cards.indices.filter({cards[$0].isFacedUp}).oneAndOnly
            /*var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFacedUp{
                    if foundIndex==nil{
                        foundIndex=index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex*/
        }
        set (newValue){
            for index in cards.indices{
                if cards[index].isFacedUp == true{
                    cards[index].isSeen = true
                }
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index),"chosen index is not in cards")//if someone use that function and have index as -1 so this line will crash and display an error
        if !cards[index].isMatched{
            flipCount += 1
            
            if let matchIndex = indexOfOneCardFaceUp ,matchIndex != index{
                //cheak if card match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                    score += 2
                }
                else if cards[matchIndex].isSeen == true || cards[index].isSeen == true {
                    score -= 1
                }
                
                cards[index].isFacedUp = true
            }else{
                //either no or 2 cards face up
                indexOfOneCardFaceUp=index
                
            }
            
        }
    }
    init(noOfPairsOfCards:Int) {
        assert(noOfPairsOfCards>0,"you must have atleast one pair of cards")
        for _ in 0..<noOfPairsOfCards{
            let card = Card()
            cards += [card , card]
        }
        cards.shuffle()
        themes += [
            Theme(name: "Faces" ,labels: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),background: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), card: #colorLiteral(red: 0.9388451578, green: 0.5745116427, blue: 0.01806676743, alpha: 1), emoji: "😅😂🤪🥶😘🥺"),
            Theme(name: "Sports" ,labels: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),background: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), card: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), emoji: "⚽️🏀🏈⚾️🥎🏐"),
            Theme(name: "Fruits" ,labels: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),background: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), card: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), emoji: "🍏🍎🍐🍊🍋🍌"),
            Theme(name: "Animals" ,labels: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),background: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), card: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), emoji: "🐶🐱🐭🦆🦄🦉"),
            Theme(name: "Vehicles" ,labels: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),background: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), card: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), emoji: "🚗🚎🛴✈️🚁🚖"),
            Theme(name: "Hearts" ,labels: #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1),background: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), card: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), emoji: "❤️🧡💚💙🖤🤎"),
        ]
        
    }
}

