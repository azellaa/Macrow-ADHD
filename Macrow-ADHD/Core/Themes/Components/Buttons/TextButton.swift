//
//  CustomTextButton.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import SwiftUI

struct TextButton: View {
    let action: () -> Void
    let contentType: TextButtonContentEnum
    var buttonStyle: TextButtonStyle.TextButtonStyleEnum = .brown
    
    init(action: @escaping () -> Void, contentType: TextButtonContentEnum, buttonStyle: TextButtonStyle.TextButtonStyleEnum = .brown) {
        self.action = action
        self.contentType = contentType
        self.buttonStyle = buttonStyle
    }
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            switch contentType {
            case .home:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.homeWhite : ResourcePath.homeBrown)
                    Text(AppLabel.home)
                        .font(.subHeading1)
                })
            case .play:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.playWhite : ResourcePath.playBrown)
                    Text(AppLabel.play)
                        .font(.subHeading1)
                })
            case .next:
                HStack(content: {
                    Text(AppLabel.next)
                        .font(.subHeading1)
                    Image(self.buttonStyle == .brown ? ResourcePath.nextWhite : ResourcePath.nextBrown)
                })
            case .previous:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.prevWhite : ResourcePath.prevBrown)
                    Text(AppLabel.previous)
                        .font(.subHeading1)
                })
            }
            
        })
        .buttonStyle(TextButtonStyle(style: self.buttonStyle))
    }
}

extension TextButton {
    enum TextButtonContentEnum {
        case home
        case play
        case next
        case previous
    }
}

#Preview {
    TextButton(action: {}, contentType: .home, buttonStyle: .lightBrown)
}
