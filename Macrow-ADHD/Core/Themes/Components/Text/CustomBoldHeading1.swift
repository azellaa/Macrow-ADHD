//
//  StrokeText.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import SwiftUI

struct CustomBoldHeading1: View {
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
        .font(.heading1)
    }
}

#Preview {
    CustomBoldHeading1(text: "Test")
        .foregroundStyle(.brown1)
}
