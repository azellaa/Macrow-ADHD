//
//  InnerShadowBox.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 21/11/23.
//

import SwiftUI

struct Container: View {
    var content: AnyView
    var containerStyle: ContainerStyleEnum
    var containerColor: ContainerColorEnum
    var width: CGFloat
    var height: CGFloat
    
    var cornerRadius: CGFloat {
        switch containerStyle {
        case .inner:
            return 20
        case .outer:
            return 30
        }
    }
    
    var color: Color {
        switch containerColor {
        case .brown:
            return .brown3
        case .lightBrown:
            return .cream2
        case .gray:
            return .gray3
        }
    }

    var body: some View {
        content
            .frame(width: width, height: height)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.shadow(.inner(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)))
                    .foregroundStyle(color)
                content
            }
    }
}

extension Container {
    enum ContainerStyleEnum {
        case inner
        case outer
    }
    
    enum ContainerColorEnum {
        case brown
        case lightBrown
        case gray
    }
}

#Preview {
    Container(content: AnyView(
    Text("Beginner")
        .font(.subHeading1)
        .foregroundColor(.cream1)
    ), containerStyle: .inner, containerColor: .brown, width: 370, height: 60)
}
