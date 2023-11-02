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
            if imageName == "chart.bar.fill" {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .zIndex(2)
                    .frame(width: 40)
                    .padding(.bottom, padding)
                    .allowsHitTesting(false)
                    .foregroundColor(.white)
            }
            else {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .zIndex(2)
                    .frame(width: 40)
                    .padding(.bottom, padding)
                    .allowsHitTesting(false)
            }
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
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .zIndex(2)
                .frame(width: 20)
                .padding(.bottom, padding)
                .allowsHitTesting(false)
                .foregroundColor(.white)
            TouchButton(padding: $padding, normalImageName: "brownIconButtonNotPressed", pressedImageName: "brownIconButtonPressed") {
                presentationMode.wrappedValue.dismiss()
            }
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
