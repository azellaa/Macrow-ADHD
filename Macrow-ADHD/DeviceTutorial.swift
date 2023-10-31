import SwiftUI

struct DeviceTutorial: View {
    @State private var currentView: Int = 0
    let maxView: Int = 10 // Set your maximum view count here
    
    
    var body: some View {
        ZStack{
            Color("creamColor")
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if currentView == 11{
                ContentView()
            } else {
                VStack{
                    HStack{
                        ButtonView(imageName: "backButton", destination: EmptyView(), buttonColor: .brownColor, iconColor: .white, width: 90, height: 80)
                            .padding(.leading, -300)
                            .padding()
                        
                        Text("Device Tutorial")
                            .font(.custom("Jua-Regular", size: 72))
                            .foregroundColor(Color.brownColor)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding(.leading, 10)
                    } .padding(.top, 80)
                    
                    
                    ZStack {
                        if currentView == 0 {
                            Subview1()
                        } else if currentView == 1 {
                            Subview2()
                        } else if currentView == 2{
                            Subview3()
                        } else if currentView == 3{
                            Subview4()
                        } else if currentView == 4{
                            Subview5()
                        } else if currentView == 5 {
                            Subview6()
                        } else if currentView == 6{
                            Subview7()
                        } else if currentView == 7{
                            Subview8()
                        } else if currentView == 8{
                            Subview9()
                        } else if currentView == 9{
                            Subview10()
                        } else if currentView == 10{
                            Subview11()
                        }
                        HStack{
                            if currentView > 0 {
                                Button(action: {
                                    currentView = (currentView - 1)
                                }) {
                                    ZStack{
                                        Image("previousBg")
                                            .resizable()
                                            .frame(width: 288, height: 88)
                                        Text("← Previous")
                                            .font(.custom("Jua-Regular", size: 32))
                                            .foregroundColor(Color.brownColor)
                                            .padding(.leading, 30)
                                    }
                                } .zIndex(1)
                                
                                
                            }
                            Spacer()
                            Button(action: {
                                currentView = (currentView + 1) // Toggle between 0 and 1
                            }) {
                                ZStack{
                                    Image("nextBg")
                                        .resizable()
                                        .frame(width: 288, height: 88)
                                    Text("Next →")
                                        .font(.custom("Jua-Regular", size: 32))
                                        .foregroundColor(Color.white)
                                        .padding(.leading, 6)
                                }
                            } .padding(.leading)
                            
                            
                        } .padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.top, 450)
                        
                    }
                }
            }
        }
    }
    
    
    
    struct Subview1: View {
        var body: some View {
            VStack{
                ZStack{
                    Image("bubble")
                        .resizable()
                        .frame(width: 381, height: 147)
                        .padding(.leading, -500)
                        .padding(.bottom, -60)
                    
                    Text("Hi! my name is Will and we will explore the forest together")
                        .font(.custom("Jua-Regular", size: 24))
                        .frame(width: 323, height: 63)
                        .foregroundColor(Color.black)
                        .padding(.bottom, -40)
                        .padding(.leading, -460)
                    
                }
                
                Image("will1")
                    .resizable()
                    .frame(width: 479, height: 595)
                
                
                
                
            } .padding(.leading)
            
        }
    }
}
    
struct Subview2: View {
    var body: some View {
        VStack{
            ZStack{
                Image("bubble")
                    .resizable()
                    .frame(width: 381, height: 147)
                    .padding(.leading, -500)
                    .padding(.bottom, -60)
                
                Text("Before we go, I’m gonna introduce you to MindWave")
                    .font(.custom("Jua-Regular", size: 24))
                    .frame(width: 323, height: 63)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -40)
                    .padding(.trailing, 620)
                  
            }
            ZStack {
                Image("will2")
                    .resizable()
                    .frame(width: 479, height: 595)
                
                Image("headpiece1")
                    .resizable()
                    .frame(width: 184, height: 248)
                    .padding(.leading, 600)
                    .padding(.top, -350)
                
            }
    
        } .padding(.leading)
            
    }
}

struct Subview3: View {
    var body: some View {
        VStack{
            ZStack{
                Image("bubble")
                    .resizable()
                    .frame(width: 381, height: 147)
                    .padding(.leading, -500)
                
                Text("MindWave is a device that shows your their brainwave activity")
                    .font(.custom("Jua-Regular", size: 24))
                    .frame(width: 357, height: 60)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 620)
                    .padding(.bottom, 10)
            }
            ZStack {
                Image("will3")
                    .resizable()
                    .frame(width: 400, height: 500)
                    .padding(.trailing, 230)
                    .padding(.bottom, 36)
                
                Image("headpiece1")
                    .resizable()
                    .frame(width: 337, height: 424)
                    .padding(.leading, 500)
                    .padding(.top, -400)
                
            }
    
        }
            
    }
}

struct Subview4: View {
    var body: some View {
        VStack{
            ZStack{
                Image("bubble")
                    .resizable()
                    .frame(width: 381, height: 147)
                    .padding(.leading, -500)
                
                Text("This is a must-have device in our journey, lets get into it")
                    .font(.custom("Jua-Regular", size: 24))
                    .frame(width: 357, height: 60)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 620)
                    .padding(.bottom, 10)
            }
            ZStack {
                Image("will3")
                    .resizable()
                    .frame(width: 400, height: 500)
                    .padding(.trailing, 230)
                    .padding(.bottom, 36)
                
                Image("headpiece1")
                    .resizable()
                    .frame(width: 337, height: 424)
                    .padding(.leading, 500)
                    .padding(.top, -400)
                
            }
    
        }
            
    }
}

struct Subview5: View {
    var body: some View {
        VStack{
            ZStack{
                Image("bubble")
                    .resizable()
                    .frame(width: 381, height: 147)
                    .padding(.leading, -500)
                
                Text("First you need to turn on the MindWave by switching the ON/OFF button")
                    .font(.custom("Jua-Regular", size: 24))
                    .frame(width: 310, height: 90)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 620)
                    .padding(.bottom, 15)
            }
            
            ZStack {
                Image("will4")
                    .resizable()
                    .frame(width: 400, height: 500)
                    .padding(.trailing, 230)
                    .padding(.bottom, 36)
                
                Image("headpieceOff")
                    .resizable()
                    .frame(width: 226, height: 226)
                    .padding(.leading, 300)
                    .padding(.bottom, 150)
                    .zIndex(3)
                    
                
                Image("line")
                    .resizable()
                    .frame(width: 160, height: 15)
                    .rotationEffect(Angle(degrees: 206))
                    .scaleEffect(x: -1, y: 1)
                    .padding(.leading, 630)
                    .padding(.bottom, 370)
                    .zIndex(2)

                    
                Image("headpiece1")
                    .resizable()
                    .frame(width: 337, height: 424)
                    .padding(.leading, 500)
                    .padding(.top, -400)
                    .zIndex(1)
                
            }
    
        }
            
    }
}

struct Subview6: View {
    var body: some View {
        VStack{
            ZStack{
                Image("bubble")
                    .resizable()
                    .frame(width: 381, height: 147)
                    .padding(.leading, -500)
                
                Text("If there is blue light, means device is on and ready to wear")
                    .font(.custom("Jua-Regular", size: 24))
                    .frame(width: 323, height: 60)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 620)
                    .padding(.bottom, 15)
            }
            
            ZStack {
                Image("will4")
                    .resizable()
                    .frame(width: 400, height: 500)
                    .padding(.trailing, 230)
                    .padding(.bottom, 36)
                
                Image("headpieceOn")
                    .resizable()
                    .frame(width: 226, height: 226)
                    .padding(.leading, 300)
                    .padding(.bottom, 150)
                    .zIndex(3)
                    
                
                Image("line")
                    .resizable()
                    .frame(width: 160, height: 15)
                    .rotationEffect(Angle(degrees: 206))
                    .scaleEffect(x: -1, y: 1)
                    .padding(.leading, 630)
                    .padding(.bottom, 370)
                    .zIndex(2)

                Image("blueLight")
                    .resizable()
                    .frame(width: 41, height: 41)
                    .padding(.bottom, 150)
                    .padding(.leading, 140)
                    .zIndex(4)
                    
                Image("headpiece1")
                    .resizable()
                    .frame(width: 337, height: 424)
                    .padding(.leading, 500)
                    .padding(.top, -400)
                    .zIndex(1)
                
            }
    
        }
            
    }
}


struct Subview7: View {
    var body: some View {
        VStack{
            ZStack{
                Image("will1")
                    .resizable()
                    .frame(width: 479, height: 595)
                    .padding(.bottom, 40)
                
                Image("headpiece1")
                    .resizable()
                    .frame(width: 306, height: 385)
                    .padding(.bottom, 230)
                    .padding(.leading, 30)
            } .padding(.top, 56)
                
                
    
        } .padding(.leading)
            
    }
}

struct Subview8: View {
    var body: some View {
        VStack{
            ZStack{
                
                Image("bubble")
                    .resizable()
                    .frame(width: 408, height: 210)
                    .padding(.trailing, 400)
                    .padding(.top, -420)
                    .zIndex(3)
                    .scaleEffect(x: -1, y: 1)

        
                Text("This is Sensor Tip, where brainwave would be detected. So, make sure it attached to the forehead skin")
                    .font(.custom("Jua-Regular", size: 24))
                    .frame(width: 355, height: 120)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 400)
                    .padding(.top, -390)
                    .zIndex(4)
                
                Image("will1")
                    .resizable()
                    .frame(width: 479, height: 595)
                    .padding(.bottom, 40)
                    .zIndex(1)
                
                Image("headpiece1")
                    .resizable()
                    .frame(width: 306, height: 385)
                    .padding(.bottom, 230)
                    .padding(.leading, 30)
                    .zIndex(2)
            }.padding(.top, 56)
                
                
    
        } .padding(.leading)
            
    }
}

struct Subview9: View {
    var body: some View {
        VStack{
            ZStack{
                
                ZStack{
                    Image("bubble")
                        .resizable()
                        .frame(width: 381, height: 135)
                        .padding(.trailing, 400)
                        .padding(.top, -420)
                        .zIndex(3)
                        .scaleEffect(x: -1, y: 1)
                    
                    
                    Text("This is ear clip and you need to clip it to your ear")
                        .font(.custom("Jua-Regular", size: 24))
                        .frame(width: 355, height: 60)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 400)
                        .padding(.top, -390)
                        .zIndex(4)
                } .zIndex(3)
                    .padding(.top, 651)
                    .padding(.leading, 190)
                
                Image("will1")
                    .resizable()
                    .frame(width: 479, height: 595)
                    .padding(.bottom, 25)
                    .zIndex(1)
                
                Image("headpiece1")
                    .resizable()
                    .frame(width: 306, height: 385)
                    .padding(.bottom, 215)
                    .padding(.leading, 30)
                    .zIndex(2)
            }.padding(.top, 40)
                
                
    
        } .padding(.leading)
            
    }
}

struct Subview10: View {
    var body: some View {
        VStack{
            ZStack{
                
                ZStack{
                    Image("flippedBubble")
                        .resizable()
                        .frame(width: 381, height: 135)
                        .padding(.leading, 400)
                        .padding(.top, -420)
                        .zIndex(3)
                    
                    Text("This is ear clip and you need to clip it to your ear")
                        .font(.custom("Jua-Regular", size: 24))
                        .frame(width: 355, height: 60)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 400)
                        .padding(.top, -375)
                        .zIndex(4)
                } .zIndex(3)
                    .padding(.top, 651)
                    .padding(.leading, 210)
                
                
                Image("will1")
                    .resizable()
                    .frame(width: 479, height: 595)
                    .padding(.bottom, 25)
                    .zIndex(1)
                
                Image("headpiece2")
                    .resizable()
                    .frame(width: 306, height: 307)
                    .padding(.bottom, 294)
                    .padding(.leading, 30)
                    .zIndex(2)
            }.padding(.top, 40)
                
                
    
        } .padding(.leading)
            
    }
}

struct Subview11: View {
    var body: some View {
        VStack{
            ZStack{
                
                ZStack{
                    Image("bubble")
                        .resizable()
                        .frame(width: 381, height: 135)
                        .padding(.leading, -500)
                        .padding(.bottom, -60)
                    
                    Text("Now device is all set and we are ready to start our journey!")
                        .font(.custom("Jua-Regular", size: 24))
                        .frame(width: 355, height: 60)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, -40)
                        .padding(.trailing, 620)
                      
                } .padding(.bottom, 600)
                    .padding(.trailing, 30)
                    .padding(.top, -120)
                    
                ZStack{
                    Image("will1")
                        .resizable()
                        .frame(width: 479, height: 595)
                        .padding(.bottom, 40)
                        .zIndex(1)
                    
                    Image("headpiece2")
                        .resizable()
                        .frame(width: 306, height: 307)
                        .padding(.bottom, 309)
                        .padding(.leading, 30)
                        .zIndex(2)
                }
                    
            }.padding(.top, 56)
                
                
    
        } .padding(.leading)
           
            
    }
}
    
    struct DeviceTutorial_Previews: PreviewProvider {
        static var previews: some View {
            DeviceTutorial()
        }
    }

