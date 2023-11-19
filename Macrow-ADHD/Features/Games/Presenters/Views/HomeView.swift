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
    @State private var headpieceIndicator = ResourcePath.headpieceDisconnected
//    @State private var symbol = "Symbol"
    
    
#if targetEnvironment(simulator)
    
    private let games: [GameInfo] = [
        GameInfo(name: AppLabel.HomeView.game1Name, description: AppLabel.HomeView.game1Description, imageName: ResourcePath.HomeView.homeHideAndSeek, mainFocus: AppLabel.HomeView.game1MainFocus),
        //        GameInfo(name: "Hide", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
        //        GameInfo(name: "Hide and ", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
    ]
#else
    private let games: [GameInfo] = [
        GameInfo(name: AppLabel.HomeView.game1Name, description: AppLabel.HomeView.game1Description, imageName: ResourcePath.HomeView.homeHideAndSeek, mainFocus: AppLabel.HomeView.game1MainFocus),
        //        GameInfo(name: "Hide", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
        //        GameInfo(name: "Hide and ", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
    ]
#endif
    
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack {
                    
                    NavigationLink {
                        StatisticViewSwift()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image(ResourcePath.statisticWhite)
                    }
                    .buttonStyle(SymbolButtonStyle(style: .brown))
                    .padding(.leading, geo.size.width * 0.03)
                    
                    Spacer()
                    Text(AppLabel.appName)
                        .font(.custom(AppFont.juaRegular, size: 86))
                        .foregroundColor(Color.brownColor)
                        .padding(.leading, 6)
                    Spacer()

                    NavigationLink {
                        GuideView()
                    } label: {
                        Image(headpieceIndicator)
                    }
                    .buttonStyle(SymbolButtonStyle(style: .brown))
                    .padding(.trailing, geo.size.width * 0.03)

                
                }
                .padding(.vertical, geo.size.height * 0.04)
                
                HStack {
                    BackCarouselButton(backName: "chevron.backward", isbackButton: true, totalGames: games.count, currentIdx: $currentIdx)
                        .frame(width: geo.size.width * 0.08)
                        .opacity(currentIdx == 0 ? 0 : 1)
                    
                    Spacer()
                    
                    ZStack {
                        ForEach(0..<games.count) { index in
                            HomeItemView(dest: Hide_SeekIntroduction(currentGame: games[index], width: geo.size.width, height: geo.size.height), gameName: games[index].name, imageName: games[index].imageName)
                                .offset(x: CGFloat(index - currentIdx) * geo.size.width * 0.9 + dragOffset, y: 0)
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
                                        currentIdx = min(games.count - 1, currentIdx + 1)
                                    }
                                }
                            })
                    )
                    
                    Spacer()
                    
                    BackCarouselButton(backName: "chevron.forward", isbackButton: false, totalGames: games.count, currentIdx: $currentIdx)
                        .frame(width: geo.size.width * 0.08)
                        .opacity(currentIdx == games.count - 1 ? 0 : 1)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image(ResourcePath.HomeView.hideAndSeekHomeBackground).resizable()
                .aspectRatio( contentMode: .fill))
        }
        .onReceive(mwmObject.signalStatusPublisher) { signalStatus in
            switch signalStatus {
            case 1:
                self.headpieceIndicator = ResourcePath.headpiece1Bar
                break
            case 2:
                self.headpieceIndicator = ResourcePath.headpiece2Bar
                break
            case 3:
                self.headpieceIndicator = ResourcePath.headpiece3Bar
                break
            case 4:
                self.headpieceIndicator = ResourcePath.headpieceConnected
                break
            default:
                self.headpieceIndicator = ResourcePath.headpieceDisconnected
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
