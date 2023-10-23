import SwiftUI

struct GuideView: View {
    @State private var selectedImage: String = "noSignal"
    
    @State private var isNoSignalTapped = true
    @State private var isPoorSignalTapped = false
    @State private var isWeakSignalTapped = false
    @State private var isConnectingTapped = false
    @State private var isConnectTapped = false
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
           
            VStack {
                HStack {
                    BackButton(width: 89, height: 79)
                        .padding(.leading, -450)
                    
                    Text("Guide")
                        .font(.custom("Jua-Regular", size: 72))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("brownGuideColor"))
                    
                }
                
                HStack {
                    Image(isNoSignalTapped ? "noSignalTapped" : "noSignal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 158, height: 119)
                        .padding(.trailing, 50)
                        .onTapGesture {
                            isNoSignalTapped = true
                            isPoorSignalTapped = false
                            isWeakSignalTapped = false
                            isConnectingTapped = false
                            isConnectTapped = false
                            selectedImage = "noSignal" // Then update selectedImage
                        }
                    
                    
                    
                    Image(isPoorSignalTapped ? "poorSignalTapped" : "poorSignal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 158, height: 119)
                        .padding(.trailing, 50)
                        .onTapGesture {
                            isNoSignalTapped = false
                            isPoorSignalTapped = true
                            isWeakSignalTapped = false
                            isConnectingTapped = false
                            isConnectTapped = false
                            selectedImage = "poorSignal"
                        }
                    
                    Image(isWeakSignalTapped ? "weakSignalTapped" : "weakSignal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 158, height: 119)
                        .padding(.trailing, 50)
                        .onTapGesture {
                            isNoSignalTapped = false
                            isPoorSignalTapped = false
                            isWeakSignalTapped = true
                            isConnectingTapped = false
                            isConnectTapped = false
                            selectedImage = "weakSignal"
                        }
                    
                    Image(isConnectingTapped ? "connectingTapped" : "connecting")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 158, height: 119)
                        .padding(.trailing, 50)
                        .onTapGesture {
                            isNoSignalTapped = false
                            isPoorSignalTapped = false
                            isWeakSignalTapped = false
                            isConnectingTapped = true
                            isConnectTapped = false
                            selectedImage = "connecting"
                        }
                    
                    Image(isConnectTapped ? "connectTapped" : "connect")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 158, height: 119)
                        .onTapGesture {
                            isNoSignalTapped = false
                            isPoorSignalTapped = false
                            isWeakSignalTapped = false
                            isConnectingTapped = false
                            isConnectTapped = true
                            selectedImage = "connect"
                        }
                }
                
                
                ZStack {
                    Image("guideExplanation")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1048, height: 134)
                    
                    VStack {
                        Text(titleForImage(imageName: selectedImage))
                            .font(.custom("Jua-Regular", size: 28))
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 152 / 255, green: 105 / 255, blue: 30 / 255))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, -3)
                        
                        
                        
                        Text(explanationForImage(imageName: selectedImage))
                            .font(.custom("Jua-Regular", size: 28))
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .foregroundColor(Color("brownGuideColor"))
                            .frame(width: 975)
                    }
                } .padding(.top, 10)
                
                HStack {
                    Image("warning")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 338, height: 321)
                        .padding(.trailing, 10)
                    
                    Image("clip")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 338, height: 321)
                        .padding(.trailing, 10)
                    
                    Image("connection")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 338, height: 321)
                }
                .padding(.top, 40)
            }
        }
    }
    
    func titleForImage(imageName: String) -> String {
        switch imageName {
        case "noSignal":
            return "NO SIGNAL"
        case "poorSignal":
            return "POOR SIGNAL"
        case "weakSignal":
            return "WEAK SIGNAL"
        case "connecting":
            return "CONNECTING"
        case "connect":
            return "CONNECTED"
        default:
            return ""
        }
    }
    
    func explanationForImage(imageName: String) -> String {
        switch imageName {
        case "noSignal":
            return "Indicates that the device is not connected."
        case "poorSignal":
            return "Attempting to establish a connection."
        case "weakSignal":
            return "Signal is relatively weak. Device attempting for a stronger connection."
        case "connecting":
            return "Device may have unstable connection. Make sure device is securely attached for a more stable connection."
        case "connect":
            return "Indicates that device is successfully established a connection."
        default:
            return ""
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
