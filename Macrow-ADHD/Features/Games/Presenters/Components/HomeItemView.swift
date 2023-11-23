//
//  HomeItemView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI

struct HomeItemView: View {
    var dest: any View
    var gameName: String
    var imageName: String
    var mainFocus: [String]
    var isLocked: Bool
    
    var body: some View {
        if !isLocked {
            HomeItemNotLocked(dest: dest, gameName: gameName, imageName: imageName, mainFocus: mainFocus)
        } else {
            HomeItemLocked(dest: dest, gameName: gameName, imageName: imageName, mainFocus: mainFocus)
        }
    }
}

struct HomeItemNotLocked: View {
    var dest: any View
    var gameName: String
    var imageName: String
    var mainFocus: [String]
    
    var body: some View {
        NavigationLink {
            AnyView(dest)
        } label: {
            HomeItemLocked(dest: dest, gameName: gameName, imageName: imageName, mainFocus: mainFocus)
        }
    }
}

struct HomeItemLocked: View {
    var dest: any View
    var gameName: String
    var imageName: String
    var mainFocus: [String]
    
    var body: some View {
        ZStack {
            Image("whiteBox")
                .resizable()
                .scaledToFit()
                .frame(width: 800)
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 700)
                Text(gameName)
                    .font(.custom("Jua-Regular", size: 64))
                    .foregroundColor(Color.brown1)
                HStack{
                    Ellipse()
                        .fill(.cream1)
                        .frame(width: 10, height: 10)
                        .padding(.trailing, 5)
                    Text(mainFocus[0])
                        .font(.custom("Jua-Regular", size: 24))
                        .foregroundColor(Color.brown1)
                        .padding(.trailing, 5)
                    Ellipse()
                        .fill(.cream1)
                        .frame(width: 10, height: 10)
                        .padding(.trailing, 5)
                    Text(mainFocus[1])
                        .font(.custom("Jua-Regular", size: 24))
                        .foregroundColor(Color.brown1)
                    Ellipse()
                        .fill(.cream1)
                        .frame(width: 10, height: 10)
                        .padding(.leading, 5)
                        
                }
            
            }
        }
    }
}

#Preview {
    HomeItemView(dest: EmptyView(), gameName: "Hide and Seek", imageName: "homeHideAndSeek", mainFocus: ["Patience", "Selective Focus"], isLocked: false)
}
