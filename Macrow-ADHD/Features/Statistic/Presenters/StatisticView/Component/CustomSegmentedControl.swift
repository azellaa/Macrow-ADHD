//
//  CustomSegmentedControl.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/1/23.
//

import Foundation
import SwiftUI
struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = Color.brown1
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = preselectedIndex == index
                ZStack {
                    Rectangle()
                        .fill(.white1)
                    
                    Rectangle()
                        .fill(color)
                        .cornerRadius(20)
                        .padding(2)
                        .opacity(isSelected ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.2,
                                                             dampingFraction: 2,
                                                             blendDuration: 0.5)) {
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(isSelected ? .white1 : .brown1)
                )
            }
        }
        .frame(height: 50)
        .cornerRadius(20)
    }
}
