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
    var buttonSize: TextButtonStyle.TextButtonSizeEnum = .big
    
    private var buttonWidthSize: CGFloat {
        switch buttonSize {
        case .big:
            return 80
        case .small:
            return 28
        }
    }
    
    init(contentType: TextButtonContentEnum, buttonStyle: TextButtonStyle.TextButtonStyleEnum = .brown, buttonSize: TextButtonStyle.TextButtonSizeEnum = .big , action: @escaping () -> Void) {
        self.action = action
        self.contentType = contentType
        self.buttonStyle = buttonStyle
        self.buttonSize = buttonSize
    }
    
    var body: some View {
        Button(action: {
            self.action()
            AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.buttonSound)
        }, label: {
            switch contentType {
            case .home:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.homeWhite : ResourcePath.homeBrown)
                        .resizable()
                        .frame(width: buttonWidthSize, height: buttonWidthSize)
                    Text(AppLabel.home)
                        .font(self.buttonSize == .big ? .heading2 : .subHeading2)
                })
            case .play:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.playWhite : ResourcePath.playBrown)
                        .resizable()
                        .frame(width: buttonWidthSize, height: buttonWidthSize)
                    Text(AppLabel.play)
                        .font(self.buttonSize == .big ? .heading2 : .subHeading2)
                })
            case .next:
                HStack(content: {
                    Text(AppLabel.next)
                        .font(self.buttonSize == .big ? .heading2 : .subHeading2)
                    Image(self.buttonStyle == .brown ? ResourcePath.nextWhite : ResourcePath.nextBrown)
                        .resizable()
                        .frame(width: buttonWidthSize, height: buttonWidthSize)
                })
            case .previous:
                HStack(content: {
                    Image(self.buttonStyle == .brown ? ResourcePath.prevWhite : ResourcePath.prevBrown)
                        .resizable()
                        .frame(width: buttonWidthSize, height: buttonWidthSize)
                    Text(AppLabel.previous)
                        .font(self.buttonSize == .big ? .heading2 : .subHeading2)
                })
            }
            
        })
        .buttonStyle(TextButtonStyle(style: self.buttonStyle, size: self.buttonSize))
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
    TextButton(contentType: .play, buttonStyle: .lightBrown, buttonSize: .small, action: {})
}
