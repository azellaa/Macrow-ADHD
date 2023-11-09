//
//  Timestamp.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct Timestamp: View {
    var char: Character
    var type: Timestamp.type = .primary
    var upperColor: Color {
        switch self.type {
        case .primary:
            return .brown1
        case .secondary:
            return .cream2
        case .tertiary:
            return .gray1
        }
    }
    var belowColor: Color {
        switch self.type {
        case .primary:
            return .brown2
        case .secondary:
            return .cream2
        case .tertiary:
            return .gray2
        }
    }
    
    var body: some View {
        Ellipse()
            .fill(belowColor)
            .frame(width: 50, height: 55)
            .overlay {
                Ellipse()
                    .fill(upperColor)
                    .frame(width: 50, height: 55)
                    .overlay {
                        Text(char.description)
                            .font(.subHeading2)
                            .foregroundStyle(.white)
                    }
                    .offset(y: -5)
            }
    }
}

extension Timestamp {
    enum type {
        case primary
        case secondary
        case tertiary
    }
}

#Preview {
    Timestamp(char: "2")
}
