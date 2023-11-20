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
                        .foregroundColor(Color.brown1)
                    HStack{
                        Ellipse()
                            .fill(.cream1)
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 5)
                        Text("Patience")
                            .font(.custom("Jua-Regular", size: 24))
                            .foregroundColor(Color.brown1)
                            .padding(.trailing, 5)
                        Ellipse()
                            .fill(.cream1)
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 5)
                        Text("Selective Focus")
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
}

#Preview {
    HomeItemView(dest: EmptyView(), gameName: "Hide and Seek", imageName: "homeHideAndSeek")
}
