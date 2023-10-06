//
//  Homepage.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/3/23.
//

import SwiftUI

struct Homepage: View {
    @State private var devName: String = ""
    @State private var mfgID: String = ""
    @State private var deviceID: String = ""
    @State var isShowingSheet = false
    
//    @ObservedObject var mwmObject: MWMInstance = MWMInstance.shared
//    @State private var mwmData: MWMData?
//    @State private var scannedMwm: Set<MWMModel>?
    @State private var isConnected: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello from SwiftUI")
                
                Text("devName: \(devName)")
                Text("mfgID: \(mfgID)")
                Text("deviceID: \(deviceID)")
                
                Button("Connect Device") {
//                    mwmObject.mwmDevice?.scanDevice()
                    isShowingSheet.toggle()
                }
                
//                if let mwmData = mwmData {
//                    Text("Poor Signal: \(mwmData.poorSignal)")
//                    Text("Attention: \(mwmData.attention)")
//                    Text("Meditation: \(mwmData.meditation)")
//                    HStack {
//                        switch mwmData.poorSignal {
//                        case 1...66:
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                        case 67...132:
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                        case 133...199:
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                        case 0:
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                            Rectangle()
//                                .frame(width: 10,  height: 10)
//                        default:
//                            Rectangle()
//                                .frame(width: 10, height: 10)
//                        }
//                    }
//                } else {
//                    Text("No data available")
//                }
                    NavigationLink(destination: ContentView()) {
                        Text("Play")
                    }
                    .navigationBarBackButtonHidden(true)
                
            }
        }
        
        
        
    }

}
//
//#Preview {
//    Homepage()
//}
