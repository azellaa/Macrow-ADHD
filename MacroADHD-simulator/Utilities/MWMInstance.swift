//
//  MWMInstance.swift
//  MacroADHD-simulator
//
//  Created by Gregorius Yuristama Nugraha on 10/25/23.
//

import Foundation
import Combine

class MWMInstance: NSObject, ObservableObject {
    
    
    public var mwmDevice: MWMDevice? = MWMDevice.shared
    
    private var mwmDataSubject = PassthroughSubject<MWMData, Never>()
    private var signalStatusSubject = PassthroughSubject<Int, Never>()
    
    public static let shared = MWMInstance()
    
    public var devName: String = ""
    public var mfgID: String = ""
    public var deviceID: String = ""
    
    var isConnected = true
    
    func deviceFound(_ devName: String!, mfgID: String!, deviceID: String!) {
//        scannedDeviceDataSubject.send(scannedDevice)
        mwmDevice?.connect(deviceID)
        
        self.devName = devName
        self.mfgID = mfgID
        self.deviceID = deviceID
    }
    
    func didConnect() {
        print("didConnect");
        self.isConnected = true
        mwmDevice?.stopScanDevice()
        signalStatusSubject.send(1)
    }
    
    func didDisconnect() {
        signalStatusSubject.send(0)
        print("didDisconnect");
//        mwmDevice?.scanDevice()
    }
    
    func eSense() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            let updatedData = MWMData(
                poorSignal: 0,
                attention: Int32(Int.random(in: 51...100)),
                meditation: 0
            )
            print(updatedData)
            switch updatedData.poorSignal {
                case 133...199:
                signalStatusSubject.send(1)
                case 67...132:
                signalStatusSubject.send(2)
                case 1...66:
                signalStatusSubject.send(3)
                case 0:
                signalStatusSubject.send(4)
                default:
                signalStatusSubject.send(0)
                }
            mwmDataSubject.send(updatedData)
        }
        
        
    }
    var mwmDataPublisher: AnyPublisher<MWMData, Never> {
        return mwmDataSubject.eraseToAnyPublisher()
    }
    
    var signalStatusPublisher: AnyPublisher<Int, Never> {
        return signalStatusSubject.eraseToAnyPublisher()
    }

}

class MWMData: ObservableObject {
    @Published var poorSignal: Int32 = 0
    @Published var attention: Int32 = 0
    @Published var meditation: Int32 = 0
    init(poorSignal: Int32, attention: Int32, meditation: Int32) {
        self.poorSignal = poorSignal
        self.attention = attention
        self.meditation = meditation
    }
}
