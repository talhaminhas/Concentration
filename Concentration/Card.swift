//
//  Card.swift
//  Concentration
//
//  Created by Minhax on 08/02/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import Foundation

struct Card:Hashable{
    var hashValue : Int{return identifier}
    
    static func == (lhs : Card,rhs : Card)-> Bool{
        return lhs.identifier == rhs.identifier
    }
    var isFacedUp=false
    var isMatched=false
    var isSeen = false
    private var identifier:Int
    private static var uniqueIdentifier = 0
    private static func getUniqueIdentifier ()->Int{
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    init() {
        self.identifier=Card.getUniqueIdentifier()
    }
}
