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
    
    init(contentType: TextButtonContentEnum, buttonStyle: TextButtonStyle.TextButtonStyleEnum = .brown, action: @escaping () -> Void) {
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
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(AppLabel.home)
                        .font(.heading2)
                })
            case .play:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.playWhite : ResourcePath.playBrown)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(AppLabel.play)
                        .font(.heading2)
                })
            case .next:
                HStack(content: {
                    Text(AppLabel.next)
                        .font(.heading2)
                    Image(self.buttonStyle == .brown ? ResourcePath.nextWhite : ResourcePath.nextBrown)
                        .resizable()
                        .frame(width: 80, height: 80)
                })
            case .previous:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.prevWhite : ResourcePath.prevBrown)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(AppLabel.previous)
                        .font(.heading2)
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
    TextButton(contentType: .play, buttonStyle: .brown, action: {})
}
