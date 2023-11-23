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
    
    public var getAllRabit: [Animal] {
        let setOfAnimal = gameToAnimal
        
        if let setOfAnimal = setOfAnimal {
            return setOfAnimal.filter{($0.animalToAnimalType!.animalTypeId == AnimalTypeEnum.rabbit.id)}
        } else {
            return []
        }
    }
    
    public var getAllFox: [Animal] {
        let setOfAnimal = gameToAnimal
        
        if let setOfAnimal = setOfAnimal {
            return setOfAnimal.filter{($0.animalToAnimalType!.animalTypeId == AnimalTypeEnum.fox.id)}
        } else {
            return []
        }
    }
    
}
