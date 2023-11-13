//
//  ThoughtBubble2.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 12/11/23.
//

import SwiftUI

struct ThoughtBubble: View {
    let text: String
    let cornerRadius = 20
    let width = 400.0
    @State private var height: CGFloat = 80.5
    
    var position: xPosition
    @State var xScale: CGFloat = 1.0
    
    private var changeScale: CGFloat {
        switch position {
        case .right:
            return 1.0
        case .left:
            return -1.0
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Shape
            ThoughtBubbleShape(cornerRadius: cornerRadius, width: width, height: height)
                .fill(Color.blue)
                .scaleEffect(CGSize(width: xScale, height: 1.0))
                .overlay(
                    ThoughtBubbleShape(cornerRadius: cornerRadius, width: width, height: height)
                        .stroke(Color.black, lineWidth: 3)
                        .scaleEffect(CGSize(width: xScale, height: 1.0))
                )
            
            // Text
            Text(text)
                .font(.custom(AppFont.juaRegular, size: 24))
                .frame(width: width - 40)
                .padding(.top, 30)
                .multilineTextAlignment(.center)
                .background(
                    TextSizeReader(height: $height)
                )
        }
        .frame(width: width, height: height)
    }
}

struct TextSizeReader: View {
    @Binding var height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: TextHeightKey.self, value: geometry.size.height)
        }
        .onPreferenceChange(TextHeightKey.self) { newHeight in
            self.height = newHeight + 40
        }
    }
}

struct TextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ThoughtBubbleShape: Shape {
    let cornerRadius: Int
    let width: Double
    let height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: CGFloat(cornerRadius), startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        
        path.addLine(to: CGPoint(x: Int(width) - cornerRadius, y: 0))
        path.addArc(center: CGPoint(x: Int(width) - cornerRadius, y: cornerRadius), radius: CGFloat(cornerRadius), startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        
        path.addArc(center: CGPoint(x: Int(width - 10), y: Int(height + 20)), radius: CGFloat(cornerRadius - 10), startAngle: .degrees(0), endAngle: .degrees(130), clockwise: false)
        
//        path.addLine(to: CGPoint(x: width, y: height + 25))
        
        path.addLine(to: CGPoint(x: width - CGFloat(cornerRadius) - 30, y: height))
        path.addLine(to: CGPoint(x: CGFloat(cornerRadius), y: height))
        
        path.addArc(center: CGPoint(x: cornerRadius, y: Int(height) - cornerRadius), radius: CGFloat(cornerRadius), startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        return path
    }
}

enum xPosition {
    case right
    case left
}



#Preview {
    ThoughtBubble(text: "This Bar Shows your fochgbh njhbnhu bnghb uhbhun uhu uhbuhu nbunu hbubunb hbr ", position: .left)
}
