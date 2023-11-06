//
//  Game+GetAnimal.swift
//  Macrow-ADHD
//
//  Created by Ich on 23/10/23.
//

import Foundation

extension Game {
    public var animals: [Animal] {
        let setOfAnimal = gameToAnimal
        
        if let setOfAnimal = setOfAnimal {
            return setOfAnimal.sorted{
                $0.id > $1.id
            }
        } else {
            return []
        }
    }
    
}
