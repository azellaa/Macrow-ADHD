//
//  DeviceTutorial.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 30/10/23.
//

import SwiftUI

struct DeviceTutorial: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    @State private var currentView: Int = 6
    let maxView: Int = 10
    var opacity: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Color(.yellow1)
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if currentView == 10 {
                    HomeView()
                        .onAppear{
                            firstLaunch = false
                        }
                } else {
                    VStack{
                        ZStack{
                            CustomBoldHeading1(text:AppLabel.DeviceTutorial.deviceTutorial)
                                .foregroundColor(Color.brownColor)
                            HStack{
                                SymbolButton(type: .close, buttonStyle: .brown, action: {
                                    presentationMode.wrappedValue.dismiss()
                                })
                                //MARK: workaround for hiding back button on onboarding
                                .opacity(opacity)
                                .padding(.horizontal)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        ZStack {
                            if currentView == 0 {
                                DeviceGuide1()
                            } else if currentView == 1 {
                                DeviceGuide2()
                            } else if currentView == 2{
                                DeviceGuide3()
                            } else if currentView == 3{
                                DeviceGuide4()
                            } else if currentView == 4{
                                DeviceGuide5()
                            } else if currentView == 5 {
                                DeviceGuide6()
                            } else if currentView == 6{
                                DeviceGuide7()
                            } else if currentView == 7{
                               DeviceGuide8()
                            } else if currentView == 8{
                                DeviceGuide9()
                            } else if currentView == 9{
                                DeviceGuide10()
                            }
                            
                            HStack{
                                if currentView > 0 {
                                    TextButton(contentType: .previous, buttonStyle: .white, buttonSize: .small) {
                                        currentView -= 1
                                    }
                                }
                                
                                Spacer()
                                
                                TextButton(contentType: .next, buttonStyle: .brown, buttonSize: .small) {
                                    currentView += 1
                                }
   
                            } .frame(width: 1130)
                                .padding(.top, geo.size.width * 0.4)
                            
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    
    
    struct DeviceGuide1: View {
        var body: some View {
            GeometryReader { geo in
                VStack{
                    ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide1Label, position: .right)
                        .position(x: geo.size.width * 0.25, y: geo.size.height * 0.17)
                    
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody4)
                        .resizable()
                        .frame(width: 478, height: 558)
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.13)
                }
            }
        }
    }
}

struct DeviceGuide2: View {
    var body: some View {
        GeometryReader { geo in
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide2Label, position: .right)
                    .position(x: geo.size.width * 0.25, y: geo.size.height * 0.15)
                
                ZStack{
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody2)
                        .resizable()
                        .frame(width: 482, height: 576)
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.13)
 
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                        .resizable()
                        .frame(width: 184, height: 248)
                        .position(x: geo.size.width * 0.7 + 62, y: geo.size.height * 0.01 - 150)
                }
            }
        }
    }
}

struct DeviceGuide3: View {
    var body: some View {
        GeometryReader { geo in
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide3Label, position: .right)
                    .position(x: geo.size.width * 0.2, y: geo.size.height * 0.2)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: geo.size.width * 0.4, y: geo.size.height * 0.18)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                        .resizable()
                        .frame(width: 337, height: 424)
                        .position(x: geo.size.width * 0.7 , y: geo.size.height * 0.01 - 80)
                }
            }
        }
    }
}

struct DeviceGuide4: View {
    var body: some View {
        GeometryReader { geo in
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide4Label, position: .right)
                    .position(x: geo.size.width * 0.2, y: geo.size.height * 0.2)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: geo.size.width * 0.4, y: geo.size.height * 0.18)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                        .resizable()
                        .frame(width: 337, height: 424)
                        .position(x: geo.size.width * 0.7 , y: geo.size.height * 0.01 - 80)
                }
            }
        }
    }
}

struct DeviceGuide5: View {
    var body: some View {
        GeometryReader { geo in
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide5Label, position: .right)
                    .position(x: geo.size.width * 0.2, y: geo.size.height * 0.2)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: geo.size.width * 0.4, y: geo.size.height * 0.18)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDetailOff)
                        .resizable()
                        .frame(width: 388, height: 438)
                        .position(x: geo.size.width * 0.7 , y: geo.size.height * 0.01 - 80)
                }
            }
        }
    }
}

struct DeviceGuide6: View {
    var body: some View {
        GeometryReader { geo in
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide6Label, position: .right)
                    .position(x: geo.size.width * 0.2, y: geo.size.height * 0.2)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: geo.size.width * 0.4, y: geo.size.height * 0.18)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDetailOn)
                        .resizable()
                        .frame(width: 388, height: 438)
                        .position(x: geo.size.width * 0.7 , y: geo.size.height * 0.01 - 80)
                }
            }
        }
    }
}


struct DeviceGuide7: View {
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.63)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: geo.size.width * 0.5 , y: geo.size.height * 0.54)
            }
        }
    }
}

struct DeviceGuide8: View {
    var body: some View {
        GeometryReader { geo in
            ZStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide8Label, position: .right)
                    .frame(width: 380, height: 182)
                    .position(x: geo.size.width * 0.22, y:geo.size.height * 0.15)
                
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.63)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: geo.size.width * 0.5 , y: geo.size.height * 0.54)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDetailSensor)
                    .resizable()
                    .frame(width: 456, height: 226)
                    .position(x: geo.size.width * 0.675, y: geo.size.height * 0.3)
                
            }
        }
    }
}


struct DeviceGuide9: View {
    var body: some View {
        GeometryReader { geo in
            ZStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide9Label, position: .right)
                    .frame(width: 380, height: 182)
                    .position(x: geo.size.width * 0.22, y:geo.size.height * 0.15)
                
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.63)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: geo.size.width * 0.5 , y: geo.size.height * 0.54)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDetailEarclip)
                    .resizable()
                    .frame(width: 409, height: 358)
                    .position(x: geo.size.width * 0.72, y: geo.size.height * 0.483)
                
            }
        }
    }
}

struct DeviceGuide10: View {
    var body: some View {
        GeometryReader { geo in
            ZStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide10Label, position: .right)
                    .frame(width: 380, height: 182)
                    .position(x: geo.size.width * 0.22, y:geo.size.height * 0.15)
                
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.63)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: geo.size.width * 0.5 , y: geo.size.height * 0.54)
            }
        }
    }
}

#Preview {
    DeviceTutorial(opacity: 0)
}
