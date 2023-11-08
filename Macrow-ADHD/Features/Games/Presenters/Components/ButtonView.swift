//
//  Button.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI

struct ButtonSymbol: View {
    @State private var padding: CGFloat = 5
    @Binding var dest: Bool
    var imageName: String
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .zIndex(2)
                .frame(width: 40)
                .padding(.bottom, padding)
                .allowsHitTesting(false)
            
            TouchButton(padding: $padding, normalImageName: "brownIconButtonNotPressed", pressedImageName: "brownIconButtonPressed") {
                dest = true
            }
        }
    }
}

struct ButtonBack: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var padding: CGFloat = 5
    
    var body: some View {
        ZStack {
            SymbolButton(action: {presentationMode.wrappedValue.dismiss()}, type: .back, buttonStyle: .brown)
        }
    }
}

struct ButtonText: View {
    @State private var padding: CGFloat = 5
    
    var imageName: String
    var text: String
    var textSize: CGFloat
    var textColor: Color
    var normalImageName: String
    var pressedImageName: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                if text == "Next" {
                    Text(text)
                        .font(.custom("Jua-Regular", size: textSize))
                        .foregroundColor(textColor)
                    
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                } else {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    
                    Text(text)
                        .font(.custom("Jua-Regular", size: textSize))
                        .foregroundColor(textColor)
                }
            }
            .zIndex(2)
            .padding(.bottom, padding)
            .allowsHitTesting(false)
            
            TouchButton(padding: $padding, normalImageName: normalImageName, pressedImageName: pressedImageName, action: action)
            
            .frame(height: 300)
        }
    }
}

struct BackCarouselButton: View {
    var backName: String
    var isbackButton: Bool
    var totalGames: Int
    @Binding var currentIdx: Int
    
    var body: some View {
        Button {
            withAnimation {
                currentIdx = isbackButton ? max(0, currentIdx - 1) : min(totalGames - 1, currentIdx + 1)
            }
        } label: {
            Image(systemName: backName)
                .resizable()
                .scaledToFit()
            //                .frame(width: geo.size.width * 0.04)
                .padding()
                .padding(.leading)
                .foregroundColor(.white)
        }
    }
}

//#Preview {
//    //    ButtonView(imageName: "chart.bar.fill", destination: EmptyView(), width: 80, height: 80)
//    //    ButtonView(imageName: "headpieceLogo", destination: EmptyView(), width: 80, height: 80)
//    BackButton(width: 80, height: 80)
//    //    BackCarouselButton()
//}
