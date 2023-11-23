
//
//  GuideView.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel Santoso on 24/10/23.
//

import SwiftUI

struct GuideView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImage: String = ResourcePath.notConnected
    @State private var selectedButton: GuideButtonType = .notConnected
    @State private var isDeviceTutorialActive = false
    
    @State private var imageName = ResourcePath.notConnected
    
    @ObservedObject var mwmObject: MWMInstance = MWMInstance.shared
    @State private var mwmData: MWMData?
    @ObservedObject var centralManager = CentralManager()
    
    @State private var isNotConnectedTapped = true
    @State private var isConnecting1Tapped = false
    @State private var isConnecting2Tapped = false
    @State private var isConnecting3Tapped = false
    @State private var isConnectedTapped = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(.yellow1)
                    .ignoresSafeArea()
                VStack{
                    ZStack {
                        CustomBoldHeading1(text: AppLabel.GuideView.guide)
                            .foregroundColor(Color.brown1)
                        HStack{
                            SymbolButton(type: .back, buttonStyle: .brown, action: {
                                presentationMode.wrappedValue.dismiss()
                            })
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 30, height: 26)
                            }
                            .buttonStyle(SymbolButtonStyle(style: .nonInteractable))
                            
                            NavigationLink(destination: DeviceTutorial( opacity: 100), isActive: $isDeviceTutorialActive) {
                                EmptyView()
                            }
                            .hidden()
                            SymbolButton(type: .guide, buttonStyle: .brown, action: {
                                isDeviceTutorialActive = true
                            })
                            .padding(.all)
                           
                            
                        } .frame(width: 1112, height: 73)
                        
                    } .navigationBarBackButtonHidden(true)
                    ZStack {
                        Spacer()
                        VStack{
                            GuideButton(action: {
                                isNotConnectedTapped = true
                                isConnecting1Tapped = false
                                isConnecting2Tapped = false
                                isConnecting3Tapped = false
                                isConnectedTapped = false
                                selectedButton = .notConnected
                            }, type: .notConnected, buttonStyle: isNotConnectedTapped ? .brown : .darkBrown)
                            
                            GuideButton(action: {
                                isNotConnectedTapped = false
                                isConnecting1Tapped = true
                                isConnecting2Tapped = false
                                isConnecting3Tapped = false
                                isConnectedTapped = false
                                selectedButton = .connecting1
                            }, type: .connecting1, buttonStyle: isConnecting1Tapped ? .brown : .darkBrown)
                            
                            GuideButton(action: {
                                isNotConnectedTapped = false
                                isConnecting1Tapped = false
                                isConnecting2Tapped = true
                                isConnecting3Tapped = false
                                isConnectedTapped = false
                                selectedButton = .connecting2
                            }, type: .connecting2, buttonStyle: isConnecting2Tapped ? .brown : .darkBrown)
                            
                            GuideButton(action: {
                                isNotConnectedTapped = false
                                isConnecting1Tapped = false
                                isConnecting2Tapped = false
                                isConnecting3Tapped = true
                                isConnectedTapped = false
                                selectedButton = .connecting3
                            }, type: .connecting3, buttonStyle: isConnecting3Tapped ? .brown : .darkBrown)
                            
                            GuideButton(action: {
                                isNotConnectedTapped = false
                                isConnecting1Tapped = false
                                isConnecting2Tapped = false
                                isConnecting3Tapped = false
                                isConnectedTapped = true
                                selectedButton = .connected
                            }, type: .connected, buttonStyle: isConnectedTapped ? .brown : .darkBrown)
                            
                        } .zIndex(0)
                            .padding(.trailing, geo.size.width * 0.84)
                        
                        ZStack{
                            VStack{
                                GuideItemView(selectedButton: $selectedButton)
                            }
                            
                        }
                        .zIndex(1)
                        .padding(.leading, geo.size.width * 0.09)
                    }
                }
            }
            
        }
        .onReceive(mwmObject.signalStatusPublisher) { signalStatus in
            switch signalStatus {
            case 1:
                self.imageName = ResourcePath.connecting1
                break
            case 2:
                self.imageName = ResourcePath.connecting2
                break
            case 3:
                self.imageName = ResourcePath.connecting3
                break
            case 4:
                self.imageName = ResourcePath.connected
                break
            default:
                self.imageName = ResourcePath.notConnected
                break
            }
        }
        
    }
}

enum GuideButtonType {
    case notConnected
    case connecting1
    case connecting2
    case connecting3
    case connected
}

#Preview{
    GuideView()
}
