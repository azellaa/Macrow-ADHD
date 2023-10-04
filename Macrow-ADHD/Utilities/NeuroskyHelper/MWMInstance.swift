//
//  MWMInstance.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/3/23.
//

import Foundation
import Combine

class MWMInstance: NSObject, MWMDelegate, ObservableObject {
    public var mwmDevice = MWMDevice.sharedInstance()
    
    private var scannedDevice: Set<MWMModel> = []
    private var mwmDataSubject = PassthroughSubject<MWMData, Never>()
    private var scannedDeviceDataSubject = PassthroughSubject<Set<MWMModel>, Never>()
    private var signalStatusSubject = PassthroughSubject<Int, Never>()
    
    public static let shared = MWMInstance()
    
    
    override init() {
        super.init()
        mwmDevice?.delegate = self
    }
    func deviceFound(_ devName: String!, mfgID: String!, deviceID: String!) {
        
        scannedDevice.insert(MWMModel(devName: devName, mfgID: mfgID, deviceID: deviceID))
        
        for device in scannedDevice {
            print(device.devName)
            print(device.deviceID)
            print(device.mfgID)
        }
        scannedDeviceDataSubject.send(scannedDevice)
        mwmDevice?.connect(deviceID)
    }
    
    func didConnect() {
        print("didConnect");
        scannedDevice.removeAll()
        self.mwmDevice?.enableLogging(withOptions: 1)
        signalStatusSubject.send(1)
    }
    
    func didDisconnect() {
        signalStatusSubject.send(0)
        print("didDisconnect");
    }
    
    func eSense(_ poorSignal: Int32, attention: Int32, meditation: Int32) {
        let updatedData = MWMData(
            poorSignal: poorSignal,
            attention: attention,
            meditation: meditation
        )
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
    var mwmDataPublisher: AnyPublisher<MWMData, Never> {
        return mwmDataSubject.eraseToAnyPublisher()
    }
    
    var signalStatusPublisher: AnyPublisher<Int, Never> {
        return signalStatusSubject.eraseToAnyPublisher()
    }
    
    var scannedMwmPublisher: AnyPublisher<Set<MWMModel>, Never> {
        return scannedDeviceDataSubject.eraseToAnyPublisher()
    }
    
    func exceptionMessage(_ eventType: TGBleExceptionEvent) {
        print("Error: \(eventType.rawValue)")
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
