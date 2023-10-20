//
//  Button.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI

struct ButtonView: View {
    var imageName: String
    var destination: any View
    var buttonColor: Color
    var iconColor: Color
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        
        NavigationLink() {
            AnyView(destination)
        } label: {
            ZStack {
                imageName == "headpieceLogo" ?
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(20) :
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(22)
            }
            .foregroundColor(iconColor)
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 30).fill(buttonColor)
            )
        }
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
            }
        }
        .foregroundColor(.white)
        .frame(width: width, height: height)
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.brownColor)
        )
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

#Preview {
//    ButtonView(imageName: "chart.bar.fill", destination: EmptyView(), width: 80, height: 80)
//    ButtonView(imageName: "headpieceLogo", destination: EmptyView(), width: 80, height: 80)
    BackButton(width: 80, height: 80)
//    BackCarouselButton()
}
