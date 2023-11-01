//
//  DetailedStatisticView.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/1/23.
//

import SwiftUI

struct DetailedStatisticView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(.bg)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    HStack {
                        BackButton(width: geo.size.width * 0.08, height: geo.size.height * 0.1)
                            .padding(.leading)
                            .padding()
                        Spacer()
                        Text("Session")
                            .font(.custom("Jua-Regular", size: 72))
                            .foregroundStyle(.brownGuide)
                        Spacer()
                    }
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width*0.8)
                            
                    }
                    .backgroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width*0.8)
                }
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    DetailedStatisticView()
}
