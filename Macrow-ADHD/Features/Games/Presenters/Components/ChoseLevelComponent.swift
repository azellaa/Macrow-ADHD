//
//  ChoseLevelComponent.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 21/11/23.
//

import SwiftUI

struct ChoseLevelComponent: View {
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    var starCount: Int
    var completionPercentage: CGFloat
    var isCompleted: Bool
    var text: String
    var maxStar: Int
    var halfStar: CGFloat
    
    init(starCount: Int, isCompleted: Bool, text: String, maxStar: Int) {
        self.starCount = starCount
        self.isCompleted = isCompleted
        self.text = text
        self.maxStar = maxStar
        if !isCompleted {
            self.completionPercentage = 0
            self.halfStar = (width * (22 / width) / 2)
        } else {
            if starCount >= maxStar {
                self.completionPercentage = 1
                self.halfStar = width * (22 / width)
            } 
            else if starCount >= maxStar / 2 {
                self.halfStar = width * (22 / width)
                self.completionPercentage = CGFloat(integerLiteral: starCount) / CGFloat(integerLiteral: maxStar)
            }
            else {
                self.completionPercentage = CGFloat(integerLiteral: starCount) / CGFloat(integerLiteral: maxStar)
                self.halfStar = (width * (22 / width) / 2)
            }
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(isCompleted ? .brown1 : .gray2)
            
            VStack {
                Container(
                    content: AnyView(
                        HStack {
                            Text(text)
                                .font(.subHeading1)
                                .foregroundColor(isCompleted ? .cream1 : .gray1)
                                .padding(.leading, width * (15 / width))
                            Spacer()
                        }
                    ),
                    containerStyle: .inner,
                    containerColor: isCompleted ? .brown : .gray,
                    width: width * (370 / width),
                    height: height * (60 / height))
                .padding(.top, height * (15 / height))
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(isCompleted ? .gray2 : .gray3)
                        .frame(width: width * (345.27 / width), height: height * (8 / height))
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(isCompleted ? .yellow3 : .gray1)
                            .frame(width: width * (345.27 / width) * completionPercentage, height: height * (8 / height))
                        Spacer()
                    }
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(isCompleted ? .yellow2 : .gray1)
                        .frame(width: width * (22 / width))
                        .padding(.leading, width * (356.27 / width) * completionPercentage - halfStar)
                }
                .padding(.top, height * (10 / height))
                .padding(.bottom, height * (15 / height))
                .padding(.leading, width * (33 / width))
            }
        }
        .frame(width: width * (410 / width), height: height * (122 / height))
    }
}

#Preview {
    ChoseLevelComponent(starCount: 100, isCompleted: true, text: "Beginner", maxStar: AppLabel.IntroductionView.maxStarLevel1)
}
