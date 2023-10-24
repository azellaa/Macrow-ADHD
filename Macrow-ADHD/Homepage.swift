//
//  Homepage.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/3/23.
//

import SwiftUI

struct Homepage: View {
    @State var isShowingSheet = false
    

    @ObservedObject var mwmObject: MWMInstance = MWMInstance.shared
    @State private var mwmData: MWMData?
    @State private var isConnected: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello from SwiftUI")
                

                Text("devName: \(mwmObject.devName)")
                Text("mfgID: \(mwmObject.mfgID)")
                Text("deviceID: \(mwmObject.deviceID)")
                Button("Connect Device") {

                    mwmObject.mwmDevice?.scanDevice()
                    isShowingSheet.toggle()
                }
                

                if let mwmData = mwmData {
                    Text("Poor Signal: \(mwmData.poorSignal)")
                    Text("Attention: \(mwmData.attention)")
                    Text("Meditation: \(mwmData.meditation)")
                    HStack {
                        switch mwmData.poorSignal {
                        case 1...66:
                            Rectangle()
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .frame(width: 10, height: 10)
                        case 67...132:
                            Rectangle()
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .frame(width: 10, height: 10)
                        case 133...199:
                            Rectangle()
                                .frame(width: 10, height: 10)
                        case 0:
                            Rectangle()
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .frame(width: 10,  height: 10)
                        default:
                            Rectangle()
                                .frame(width: 10, height: 10)
                        }
                    }
                } else {
                    Text("No data available")
                }
                //                if isConnected {
#if DEBUG
                NavigationLink(destination: ContentView()) {
                    Text("Play")
                }
#else
                NavigationLink(destination: ContentView()
                    .navigationBarBackButtonHidden(true)) {
                        Text("Play")
                    }
#endif
                //                }
                
            }
            
        }
        
        .onReceive(mwmObject.mwmDataPublisher, perform: { mwmData in
            self.mwmData = mwmData
            //            print(mwmData.attention)
        })
        .onReceive(mwmObject.signalStatusPublisher, perform: { signalStatus in
            if signalStatus == 0 {
                self.isConnected = false
            }
            else {
                self.isConnected = true
                self.isShowingSheet = false
            }
        })
    }
    
}
//
//#Preview {
//    Homepage()
//}
