//
//  AnimalTypeEnum.swift
//  Macrow-ADHD
//
//  Created by Ich on 20/10/23.
//

import Foundation

enum AnimalTypeEnum{
    case rabbit
    case fox

    var id: Int {
        switch self {
        case .rabbit:
            return 0
        case .fox:
            return 1
        }
    }

    var name: String {
        switch self {
        case .rabbit:
            return "Rabbit"
        case .fox:
            return "Fox"
        }
    }
}
