//
//  StrokeText.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import SwiftUI

struct CustomBoldHeading2: View {
    let text: String

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  Decimal.double1, y:  Decimal.double1)
                Text(text).offset(x: -Decimal.double1, y: -Decimal.double1)
                Text(text).offset(x: -Decimal.double1, y: Decimal.double1)
                Text(text).offset(x:  Decimal.double1, y: -Decimal.double1)
            }
            Text(text)
        }
        .font(.heading2)
    }
}

//#Preview {
//    StrokeText(text: "Sample Text", width: 0.5, color: .red)
//        .foregroundColor(.black)
//        .font(.system(size: 12, weight: .bold))
//}
