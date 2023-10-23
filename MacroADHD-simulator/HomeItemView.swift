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
    
    var body: some View {
        NavigationLink {
            AnyView(dest)
        } label: {
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
                        .foregroundColor(Color.brownColor)
                }
            }
        }
    }
}

#Preview {
    HomeItemView(dest: EmptyView(), gameName: "Hide and Seek", imageName: "homeHideAndSeek")
}
