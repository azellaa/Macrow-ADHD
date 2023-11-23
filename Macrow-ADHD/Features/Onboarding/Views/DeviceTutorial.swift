//
//  DeviceTutorial.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 30/10/23.
//

import SwiftUI

struct DeviceTutorial: View {
    @Environment(\.presentationMode) var presentationMode
    //FIXME: for demo purposes delete appstorage wrapper
    @State var firstLaunch: Bool = true
    @State private var currentView: Int = 0
    let maxView: Int = 10
    var opacity: CGFloat
    
    var body: some View {
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
                                .foregroundColor(Color.brown1)
                                .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.07)
                            HStack{
                                SymbolButton(type: .close, buttonStyle: .brown, action: {
                                    presentationMode.wrappedValue.dismiss()
                                })
                                //MARK: workaround for hiding back button on onboarding
                                .opacity(opacity)
                                .position(x: UIScreen.main.bounds.width * 0.05, y: UIScreen.main.bounds.height * 0.07)
                                .padding(.horizontal)
                            }
                        }
                        
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
                                .padding(.top, UIScreen.main.bounds.width * 0.4)
                            
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
    
    
    
    struct DeviceGuide1: View {
        var body: some View {
                VStack{
                    ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide1Label, position: .right)
                        .position(x: UIScreen.main.bounds.width * 0.25, y: UIScreen.main.bounds.height * -0.05)
                    
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody4)
                        .resizable()
                        .frame(width: 478, height: 558)
                        .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.02 )
                }
            }
        }
    }

struct DeviceGuide2: View {
    var body: some View {
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide2Label, position: .right)
                    .position(x: UIScreen.main.bounds.width * 0.25, y:UIScreen.main.bounds.height * -0.05)
                
                ZStack{
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody2)
                        .resizable()
                        .frame(width: 482, height: 576)
                        .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.02)
 
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                        .resizable()
                        .frame(width: 184, height: 248)
                        .position(x: UIScreen.main.bounds.width * 0.7 + 62, y: UIScreen.main.bounds.height * -0.25)
                }
            }
        }
    }

struct DeviceGuide3: View {
    var body: some View {
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide3Label, position: .right)
                    .position(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * -0.02)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: UIScreen.main.bounds.width * 0.4, y: UIScreen.main.bounds.height * 0.05)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                        .resizable()
                        .frame(width: 337, height: 424)
                        .position(x: UIScreen.main.bounds.width * 0.7 , y: UIScreen.main.bounds.height * -0.15)
                }
            }
        }
    }

struct DeviceGuide4: View {
    var body: some View {
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide4Label, position: .right)
                    .position(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * -0.02)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: UIScreen.main.bounds.width * 0.4, y: UIScreen.main.bounds.height * 0.05)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                        .resizable()
                        .frame(width: 337, height: 424)
                        .position(x: UIScreen.main.bounds.width * 0.7 , y: UIScreen.main.bounds.height * -0.15)
                }
            }
        }
    }

struct DeviceGuide5: View {
    var body: some View {
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide5Label, position: .right)
                    .position(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * -0.02)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: UIScreen.main.bounds.width * 0.4, y: UIScreen.main.bounds.height * 0.05)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDetailOff)
                        .resizable()
                        .frame(width: 388, height: 438)
                        .position(x: UIScreen.main.bounds.width * 0.7 , y: UIScreen.main.bounds.height * -0.15)
                }
            }
        }
    }

struct DeviceGuide6: View {
    var body: some View {
            VStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide6Label, position: .right)
                    .position(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * -0.02)
                
                ZStack {
                    Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                        .resizable()
                        .frame(width: 400, height: 500)
                        .position(x: UIScreen.main.bounds.width * 0.4, y: UIScreen.main.bounds.height * 0.05)
                    
                    
                    Image(ResourcePath.DeviceTutorial.device.deviceDetailOn)
                        .resizable()
                        .frame(width: 388, height: 438)
                        .position(x: UIScreen.main.bounds.width * 0.7 , y: UIScreen.main.bounds.height * -0.15)
                }
            }
        }
    }

struct DeviceGuide7: View {
    var body: some View {
            ZStack{
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.34)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: UIScreen.main.bounds.width * 0.5 , y: UIScreen.main.bounds.height * 0.25)
            }
        }
    }

struct DeviceGuide8: View {
    var body: some View {
            ZStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide8Label, position: .right)
                    .frame(width: 380, height: 182)
                    .position(x: UIScreen.main.bounds.width * 0.22, y:UIScreen.main.bounds.height * -0.06)
                
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.34)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: UIScreen.main.bounds.width * 0.5 , y: UIScreen.main.bounds.height * 0.25)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDetailSensor)
                    .resizable()
                    .frame(width: 456, height: 226)
                    .position(x: UIScreen.main.bounds.width * 0.675, y: UIScreen.main.bounds.height * 0.07)
                
            }
        }
    }

struct DeviceGuide9: View {
    var body: some View {
            ZStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide9Label, position: .right)
                    .frame(width: 380, height: 182)
                    .position(x: UIScreen.main.bounds.width * 0.22, y: UIScreen.main.bounds.height * -0.06)
                
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.34)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: UIScreen.main.bounds.width * 0.5 , y: UIScreen.main.bounds.height * 0.25)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDetailEarclip)
                    .resizable()
                    .frame(width: 409, height: 358)
                    .position(x: UIScreen.main.bounds.width * 0.72, y: UIScreen.main.bounds.height * 0.24)
                
            }
        }
    }

struct DeviceGuide10: View {
    var body: some View {
            ZStack{
                ThoughtBubble(text: AppLabel.DeviceTutorial.deviceGuide10Label, position: .right)
                    .frame(width: 380, height: 182)
                    .position(x: UIScreen.main.bounds.width * 0.22, y: UIScreen.main.bounds.height * -0.06)
                
                Image(ResourcePath.DeviceTutorial.willHalfBody.willHalfBody3)
                    .resizable()
                    .frame(width: 490, height: 573)
                    .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.34)
                
                Image(ResourcePath.DeviceTutorial.device.deviceDefault)
                    .resizable()
                    .frame(width: 306, height: 385)
                    .position(x: UIScreen.main.bounds.width * 0.5 , y: UIScreen.main.bounds.height * 0.25)
            }
        }
    }


#Preview {
    DeviceTutorial(opacity: 0)
}
