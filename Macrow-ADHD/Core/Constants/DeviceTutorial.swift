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


//
//  DeviceTutorial.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 30/10/23.
//
//
//import SwiftUI
//
//struct DeviceTutorial: View {
//    @Environment(\.presentationMode) var presentationMode
//    @AppStorage("firstLaunch") var firstLaunch: Bool = true
//    @State private var currentView: Int = 0
//    let maxView: Int = 10 // Set your maximum view count here
//    var opacity: CGFloat
//
//    var body: some View {
//        ZStack{
//            Color(.yellow1)
//                .edgesIgnoringSafeArea(.all)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//            if currentView == 11{
//                HomeView()
//                    .onAppear{
//                        firstLaunch = false
//                    }
//            } else {
//                VStack{
//                    ZStack{
//                        Text("Device Tutorial")
//                            .font(.custom("Jua-Regular", size: 72))
//                            .foregroundColor(Color.brownColor)
//                            .font(.largeTitle)
//                            .fontWeight(.heavy)
//
//                        HStack{
//
//                            SymbolButton(type: .close, buttonStyle: .brown, action: {
//                                presentationMode.wrappedValue.dismiss()
//                            })
//                            //MARK: workaround for hiding back button on onboarding
//                            .opacity(opacity)
//                            .padding(.horizontal)
//                            Spacer()
//
//                        }
//
//                    } .padding(.top, 80)
//
//                    Spacer()
//                    ZStack {
//                        if currentView == 0 {
//                            Subview1()
//                        } else if currentView == 1 {
//                            Subview2()
//                        } else if currentView == 2{
//                            Subview3()
//                        } else if currentView == 3{
//                            Subview4()
//                        } else if currentView == 4{
//                            Subview5()
//                        } else if currentView == 5 {
//                            Subview6()
//                        } else if currentView == 6{
//                            Subview7()
//                        } else if currentView == 7{
//                            Subview8()
//                        } else if currentView == 8{
//                            Subview9()
//                        } else if currentView == 9{
//                            Subview10()
//                        } else if currentView == 10{
//                            Subview11()
//                        }
//                        HStack{
//                            if currentView > 0 {
//                                ButtonText(imageName: "IconPrevBrown", text: "Previous", textSize: 32, textColor: .brownColor, normalImageName: "whiteTextButtonNotPressed", pressedImageName: "whiteTextButtonPressed") {
//                                    currentView -= 1
//                                }
//                                .zIndex(1)
//                            }
//                            Spacer()
//
//                            ButtonText(imageName: "IconNextWhite", text: "Next", textSize: 32, textColor: .white, normalImageName: "brownTextButtonNotPressed", pressedImageName: "brownTextButtonPressed") {
//                                currentView += 1
//                            }
//                            .padding(.leading)
//
//
//                        }
//                        .padding(.horizontal, 30)
//                        .padding(.top, 450)
//
//                    }
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//
//
//
//
//    struct Subview1: View {
//        var body: some View {
//            VStack{
//                ZStack{
//                    Image("bubble")
//                        .resizable()
//                        .frame(width: 381, height: 147)
//                        .padding(.leading, -500)
//                        .padding(.bottom, -60)
//
//                    Text("Hi! my name is Will and we will explore the forest together")
//                        .font(.custom("Jua-Regular", size: 24))
//                        .frame(width: 323, height: 63)
//                        .foregroundColor(Color.black)
//                        .padding(.bottom, -40)
//                        .padding(.leading, -460)
//
//                }
//
//                Image("will1")
//                    .resizable()
//                    .frame(width: 479, height: 595)
//
//
//
//
//            }
//
//        }
//    }
//}
//
//struct Subview2: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                Image("bubble")
//                    .resizable()
//                    .frame(width: 381, height: 147)
//                    .padding(.leading, -500)
//                    .padding(.bottom, -60)
//
//                Text("Before we go, I’m gonna introduce you to MindWave")
//                    .font(.custom("Jua-Regular", size: 24))
//                    .frame(width: 323, height: 63)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//                    .padding(.bottom, -40)
//                    .padding(.trailing, 620)
//
//            }
//            ZStack {
//                Image("will2")
//                    .resizable()
//                    .frame(width: 479, height: 595)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 184, height: 248)
//                    .padding(.leading, 600)
//                    .padding(.top, -350)
//
//            }
//
//        } .padding(.leading)
//
//    }
//}
//
//struct Subview3: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                Image("bubble")
//                    .resizable()
//                    .frame(width: 381, height: 147)
//                    .padding(.leading, -500)
//
//                Text("MindWave is a device that shows your their brainwave activity")
//                    .font(.custom("Jua-Regular", size: 24))
//                    .frame(width: 357, height: 60)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//                    .padding(.trailing, 620)
//                    .padding(.bottom, 10)
//            }
//            ZStack {
//                Image("will3")
//                    .resizable()
//                    .frame(width: 400, height: 500)
//                    .padding(.trailing, 230)
//                    .padding(.bottom, 36)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 337, height: 424)
//                    .padding(.leading, 500)
//                    .padding(.top, -400)
//
//            }
//
//        }
//
//    }
//}
//
//struct Subview4: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                Image("bubble")
//                    .resizable()
//                    .frame(width: 381, height: 147)
//                    .padding(.leading, -500)
//
//                Text("This is a must-have device in our journey, lets get into it")
//                    .font(.custom("Jua-Regular", size: 24))
//                    .frame(width: 357, height: 60)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//                    .padding(.trailing, 620)
//                    .padding(.bottom, 10)
//            }
//            ZStack {
//                Image("will3")
//                    .resizable()
//                    .frame(width: 400, height: 500)
//                    .padding(.trailing, 230)
//                    .padding(.bottom, 36)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 337, height: 424)
//                    .padding(.leading, 500)
//                    .padding(.top, -400)
//
//            }
//
//        }
//
//    }
//}
//
//struct Subview5: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                Image("bubble")
//                    .resizable()
//                    .frame(width: 381, height: 147)
//                    .padding(.leading, -500)
//
//                Text("First you need to turn on the MindWave by switching the ON/OFF button")
//                    .font(.custom("Jua-Regular", size: 24))
//                    .frame(width: 310, height: 90)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//                    .padding(.trailing, 620)
//                    .padding(.bottom, 15)
//            }
//
//            ZStack {
//                Image("will4")
//                    .resizable()
//                    .frame(width: 400, height: 500)
//                    .padding(.trailing, 230)
//                    .padding(.bottom, 36)
//
//                Image("headpieceOff")
//                    .resizable()
//                    .frame(width: 226, height: 226)
//                    .padding(.leading, 300)
//                    .padding(.bottom, 150)
//                    .zIndex(3)
//
//
//                Image("line")
//                    .resizable()
//                    .frame(width: 160, height: 15)
//                    .rotationEffect(Angle(degrees: 206))
//                    .scaleEffect(x: -1, y: 1)
//                    .padding(.leading, 630)
//                    .padding(.bottom, 370)
//                    .zIndex(2)
//
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 337, height: 424)
//                    .padding(.leading, 500)
//                    .padding(.top, -400)
//                    .zIndex(1)
//
//            }
//
//        }
//
//    }
//}
//
//struct Subview6: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                Image("bubble")
//                    .resizable()
//                    .frame(width: 381, height: 147)
//                    .padding(.leading, -500)
//
//                Text("If there is blue light, means device is on and ready to wear")
//                    .font(.custom("Jua-Regular", size: 24))
//                    .frame(width: 323, height: 60)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//                    .padding(.trailing, 620)
//                    .padding(.bottom, 15)
//            }
//
//            ZStack {
//                Image("will4")
//                    .resizable()
//                    .frame(width: 400, height: 500)
//                    .padding(.trailing, 230)
//                    .padding(.bottom, 36)
//
//                Image("headpieceOn")
//                    .resizable()
//                    .frame(width: 226, height: 226)
//                    .padding(.leading, 300)
//                    .padding(.bottom, 150)
//                    .zIndex(3)
//
//
//                Image("line")
//                    .resizable()
//                    .frame(width: 160, height: 15)
//                    .rotationEffect(Angle(degrees: 206))
//                    .scaleEffect(x: -1, y: 1)
//                    .padding(.leading, 630)
//                    .padding(.bottom, 370)
//                    .zIndex(2)
//
//                Image("blueLight")
//                    .resizable()
//                    .frame(width: 41, height: 41)
//                    .padding(.bottom, 150)
//                    .padding(.leading, 140)
//                    .zIndex(4)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 337, height: 424)
//                    .padding(.leading, 500)
//                    .padding(.top, -400)
//                    .zIndex(1)
//
//            }
//
//        }
//
//    }
//}
//
//
//struct Subview7: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                Image("will1")
//                    .resizable()
//                    .frame(width: 479, height: 595)
//                    .padding(.bottom, 40)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 306, height: 385)
//                    .padding(.bottom, 230)
//                    .padding(.leading, 30)
//            } .padding(.top, 56)
//
//
//
//        } .padding(.leading)
//
//    }
//}
//
//struct Subview8: View {
//    var body: some View {
//        VStack{
//            ZStack{
//
//                Image("bubble")
//                    .resizable()
//                    .frame(width: 408, height: 210)
//                    .padding(.trailing, 400)
//                    .padding(.top, -420)
//                    .zIndex(3)
//                    .scaleEffect(x: -1, y: 1)
//
//
//                Text("This is Sensor Tip, where brainwave would be detected. So, make sure it attached to the forehead skin")
//                    .font(.custom("Jua-Regular", size: 24))
//                    .frame(width: 355, height: 120)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//                    .padding(.leading, 400)
//                    .padding(.top, -390)
//                    .zIndex(4)
//
//                Image("will1")
//                    .resizable()
//                    .frame(width: 479, height: 595)
//                    .padding(.bottom, 40)
//                    .zIndex(1)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 306, height: 385)
//                    .padding(.bottom, 230)
//                    .padding(.leading, 30)
//                    .zIndex(2)
//            }.padding(.top, 56)
//
//
//
//        } .padding(.leading)
//
//    }
//}
//
//struct Subview9: View {
//    var body: some View {
//        VStack{
//            ZStack{
//
//                ZStack{
//                    Image("bubble")
//                        .resizable()
//                        .frame(width: 381, height: 135)
//                        .padding(.trailing, 400)
//                        .padding(.top, -420)
//                        .zIndex(3)
//                        .scaleEffect(x: -1, y: 1)
//
//
//                    Text("This is ear clip and you need to clip it to your ear")
//                        .font(.custom("Jua-Regular", size: 24))
//                        .frame(width: 355, height: 60)
//                        .foregroundColor(Color.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.leading, 400)
//                        .padding(.top, -390)
//                        .zIndex(4)
//                } .zIndex(3)
//                    .padding(.top, 651)
//                    .padding(.leading, 190)
//
//                Image("will1")
//                    .resizable()
//                    .frame(width: 479, height: 595)
//                    .padding(.bottom, 25)
//                    .zIndex(1)
//
//                Image("headpiece1")
//                    .resizable()
//                    .frame(width: 306, height: 385)
//                    .padding(.bottom, 215)
//                    .padding(.leading, 30)
//                    .zIndex(2)
//            }.padding(.top, 40)
//
//
//
//        } .padding(.leading)
//
//    }
//}
//
//struct Subview10: View {
//    var body: some View {
//        VStack{
//            ZStack{
//
//                ZStack{
//                    Image("flippedBubble")
//                        .resizable()
//                        .frame(width: 381, height: 135)
//                        .padding(.leading, 400)
//                        .padding(.top, -420)
//                        .zIndex(3)
//
//                    Text("This is ear clip and you need to clip it to your ear")
//                        .font(.custom("Jua-Regular", size: 24))
//                        .frame(width: 355, height: 60)
//                        .foregroundColor(Color.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.leading, 400)
//                        .padding(.top, -375)
//                        .zIndex(4)
//                } .zIndex(3)
//                    .padding(.top, 651)
//                    .padding(.leading, 210)
//
//
//                Image("will1")
//                    .resizable()
//                    .frame(width: 479, height: 595)
//                    .padding(.bottom, 25)
//                    .zIndex(1)
//
//                Image("headpiece2")
//                    .resizable()
//                    .frame(width: 306, height: 307)
//                    .padding(.bottom, 294)
//                    .padding(.leading, 30)
//                    .zIndex(2)
//            }.padding(.top, 40)
//
//
//
//        } .padding(.leading)
//
//    }
//}
//
//struct Subview11: View {
//    var body: some View {
//        VStack{
//            ZStack{
//
//                ZStack{
//                    Image("bubble")
//                        .resizable()
//                        .frame(width: 381, height: 135)
//                        .padding(.leading, -500)
//                        .padding(.bottom, -60)
//
//                    Text("Now device is all set and we are ready to start our journey!")
//                        .font(.custom("Jua-Regular", size: 24))
//                        .frame(width: 355, height: 60)
//                        .foregroundColor(Color.black)
//                        .multilineTextAlignment(.center)
//                        .padding(.bottom, -40)
//                        .padding(.trailing, 620)
//
//                }
//                .padding(.bottom, 600)
//                .padding(.trailing, 30)
//                .padding(.top, -120)
//
//                ZStack{
//                    Image("will1")
//                        .resizable()
//                        .frame(width: 479, height: 595)
//                        .padding(.bottom, 40)
//                        .zIndex(1)
//
//                    Image("headpiece2")
//                        .resizable()
//                        .frame(width: 306, height: 307)
//                        .padding(.bottom, 309)
//                        .padding(.leading, 30)
//                        .zIndex(2)
//                }
//            }
//            .padding(.top, 56)
//        }
//        .padding(.leading)
//    }
//}
//
//struct DeviceTutorial_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceTutorial( opacity: 0)
//    }
//}
//
//
