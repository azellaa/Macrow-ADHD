//
//  HomeView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI

struct HomeView: View {
    @State private var currentIdx: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    @State var isStatistic: Bool = false
    @State var isGuide: Bool = false
    
    @ObservedObject var mwmObject: MWMInstance = MWMInstance.shared
    @State private var mwmData: MWMData?
    @ObservedObject var centralManager = CentralManager()
    @State private var headpieceIndicator = ResourcePath.notConnected
    
    var gameCount = GameInfoLabel.games.count
    
    var body: some View {
        VStack{
            HStack {
                NavigationLink {
                    StatisticViewSwift()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(ResourcePath.statisticWhite)
                }
                .buttonStyle(SymbolButtonStyle(style: .brown))
                .padding(.leading, UIScreen.main.bounds.width * 0.03)
                
                Spacer()
                Text(AppLabel.appName)
                    .font(.custom(AppFont.juaRegular, size: 86))
                    .foregroundColor(.brown1)
                    .padding(.leading, 6)
                Spacer()
                
                NavigationLink {
                    GuideView()
                } label: {
                    Image(headpieceIndicator)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(SymbolButtonStyle(style: .brown))
                .padding(.trailing, UIScreen.main.bounds.width * 0.03)
                
                
            }
            .padding(.vertical, UIScreen.main.bounds.height * 0.04)
            
            ZStack {
                ForEach(0..<gameCount, id: \.self) { index in
                    HomeItemView(dest: Hide_SeekIntroduction(currentGame: GameInfoLabel.games[index], width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), gameName: GameInfoLabel.games[index].name, imageName: GameInfoLabel.games[index].imageName)
                        .offset(x: CGFloat(index - currentIdx) * UIScreen.main.bounds.width * 0.9 + dragOffset, y: 0)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIdx = max(0, currentIdx - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIdx = min(GameInfoLabel.games.count - 1, currentIdx + 1)
                            }
                        }
                    })
            )
            
            HStack {
                ForEach(0..<gameCount, id: \.self) { index in
                    if index == currentIdx {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.yellow2)
                            .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.024)
                    } else {
                        Circle()
                            .fill(.yellow3)
                            .frame(height: UIScreen.main.bounds.height * 0.024)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            ZStack {
                ForEach(0..<gameCount, id: \.self) { index in
                    Image(ResourcePath.HomeView.hideAndSeekHomeBackground).resizable()
                    .aspectRatio( contentMode: .fill)
                    .offset(x: CGFloat(index - currentIdx) * UIScreen.main.bounds.width + dragOffset, y: 0)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIdx = max(0, currentIdx - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIdx = min(GameInfoLabel.games.count - 1, currentIdx + 1)
                            }
                        }
                    })
            )
        )
        .onReceive(mwmObject.signalStatusPublisher) { signalStatus in
            switch signalStatus {
            case 1:
                self.headpieceIndicator = ResourcePath.connecting1
                break
            case 2:
                self.headpieceIndicator = ResourcePath.connecting2
                break
            case 3:
                self.headpieceIndicator = ResourcePath.connecting3
                break
            case 4:
                self.headpieceIndicator = ResourcePath.connected
                break
            default:
                self.headpieceIndicator = ResourcePath.notConnected
                break
            }
        }
        .onChange(of: centralManager.isBluetoothOn) { isBluetoothOn in
            if isBluetoothOn && !mwmObject.isConnected{
                print(isBluetoothOn)
                mwmObject.mwmDevice?.scanDevice()
            }
        }
        .onAppear{
            mwmObject.mwmDevice?.scanDevice()
#if targetEnvironment(simulator)
            mwmObject.eSense()
#endif
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    HomeView()
        .previewInterfaceOrientation(.landscapeRight)
}
