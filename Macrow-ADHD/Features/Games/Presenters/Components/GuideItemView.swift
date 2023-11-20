//
//  GuideItemView.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 08/11/23.
//

import SwiftUI

struct GuideItemView: View {
    @State private var onCreamShowed = true
    @State private var bluetoothCreamShowed = true
    @State private var sensorCreamShowed = true
    @State private var placeCreamShowed = true
    @State private var headCreamShowed = true
    @Binding var selectedButton: GuideButtonType
    
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 1003, height: 580)
                .cornerRadius(30)
                .foregroundColor(Color.brownGuide)
            VStack{
                
                VStack {
                    Image(imageHeadpiece())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                    
                    Spacer()
                    
                    Text(titleForImage())
                        .font(.subHeading1)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    Text(explanationForImage())
                        .font(.body1)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    ZStack{
                        Image(ResourcePath.GuideView.shadowRectangleBrown)
                            .frame(width: 946, height: 198)
                        GeometryReader { geometry in
                            HStack(spacing: 20){
                                ForEach(creams.indices, id: \.self) { index in
                                    VStack {
                                        if creams[index].show {
                                            Image(creams[index].image)
                                                .frame(width: 70, height: 36)
                                                .padding(.top)
                                            Spacer()
                                            Text(creams[index].label)
                                                .frame(width: 204, height: 50)
                                                .multilineTextAlignment(.center)
                                                .font(.body2)
                                                .foregroundColor(.cream)
                                                .padding(.bottom)
                                            
                                        }
                                    }                        
                                    .frame(width: 204, height: 158)
                                    .padding(.leading, geometry.size.width * 0.02)
                                    .padding(.top, geometry.size.height * 0.15)
                                    
                                    
                                }
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                        }
                        
                        
                    }
                } .frame(width: 946, height: 528)
                
            }
            
        } 
    }
    
    
    func imageHeadpiece() -> String {
        switch selectedButton {
        case .notConnected:
            return ResourcePath.notConnected
        case .connecting1:
            return ResourcePath.connecting1
        case .connecting2:
            return ResourcePath.connecting2
        case .connecting3:
            return ResourcePath.connecting3
        case .connected:
            return ResourcePath.connected
        }
    }
    var creams: [Cream] {
        switch selectedButton {
        case .notConnected:
            return [
                Cream(image: ResourcePath.GuideView.onCream, label: AppLabel.GuideView.IconLabel.onLabel, show: true),
                Cream(image: ResourcePath.GuideView.bluetoothCream, label: AppLabel.GuideView.IconLabel.bluetoothLabel, show: true),
                Cream(image: ResourcePath.GuideView.sensorCream, label: AppLabel.GuideView.IconLabel.sensorLabel, show: true),
                Cream(image: ResourcePath.GuideView.headCream, label: AppLabel.GuideView.IconLabel.headLabel, show: true)
                
            ]
        case .connecting1:
            return [
                Cream(image: ResourcePath.GuideView.bluetoothCream, label: AppLabel.GuideView.IconLabel.bluetoothLabel, show: true),
                Cream(image: ResourcePath.GuideView.placeCream, label: AppLabel.GuideView.IconLabel.placeLabel, show: true),
                Cream(image: ResourcePath.GuideView.sensorCream, label: AppLabel.GuideView.IconLabel.sensorLabel, show: true),
                Cream(image: ResourcePath.GuideView.headCream, label: AppLabel.GuideView.IconLabel.headLabel, show: true)
            ]
        case .connecting2, .connecting3:
            return [
                Cream(image: ResourcePath.GuideView.bluetoothCream, label: AppLabel.GuideView.IconLabel.bluetoothLabel, show: true),
                Cream(image: ResourcePath.GuideView.placeCream, label: AppLabel.GuideView.IconLabel.placeLabel, show: true),
                Cream(image: ResourcePath.GuideView.sensorCream, label: AppLabel.GuideView.IconLabel.sensorLabel, show: true),
                Cream(image: ResourcePath.GuideView.headCream, label: AppLabel.GuideView.IconLabel.headLabel, show: true)
            ]
        case .connected:
            return [
                Cream(image: ResourcePath.GuideView.headCream, label: AppLabel.GuideView.IconLabel.headLabel, show: true)
            ]
        }
    }
    
    func titleForImage() -> String {
        switch selectedButton {
        case .notConnected:
            return AppLabel.GuideView.HeadpieceLabel.notConnectedLabel
        case .connecting1:
            return AppLabel.GuideView.HeadpieceLabel.connecting1Label
        case .connecting2:
            return AppLabel.GuideView.HeadpieceLabel.connecting2Label
        case .connecting3:
            return AppLabel.GuideView.HeadpieceLabel.connecting3Label
        case .connected:
            return AppLabel.GuideView.HeadpieceLabel.connectedLabel
        }
    }
    
    func explanationForImage() -> String {
        switch selectedButton {
        case .notConnected:
            return AppLabel.GuideView.HeadpieceInfo.notConnectedInfo
        case .connecting1:
            return AppLabel.GuideView.HeadpieceInfo.connecting1Info
        case .connecting2:
            return AppLabel.GuideView.HeadpieceInfo.connecting2Info
        case .connecting3:
            return AppLabel.GuideView.HeadpieceInfo.connecting3Info
        case .connected:
            return AppLabel.GuideView.HeadpieceInfo.connectedInfo
        }
    }
}
struct Cream {
    var image: String
    var label: String
    var show: Bool
}

#Preview {
    GuideItemView(selectedButton: .constant(.notConnected))
}
