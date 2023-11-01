//
//  MWMDevice.swift
//  MacroADHD-simulator
//
//  Created by Gregorius Yuristama Nugraha on 10/25/23.
//

import Foundation

class MWMDevice {
    public static let shared = MWMDevice()
    
    func scanDevice() {
        print("Scan device simulator (dummy)")
    }
    func stopScanDevice() {
        print("stop scan device simulator (dummy)")
    }
    
    func connect(_ deviceID: String) {
        print("Connecting to \(deviceID) (dummy)")
    }
}
