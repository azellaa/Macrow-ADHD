//
//  CentralManager.swift
//  Macrow-ADHD
//
//  Created by Ich on 23/10/23.
//

import Foundation

import CoreBluetooth
import Combine

class CentralManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var isBluetoothOn: Bool = false
    var centralManager: CBCentralManager!

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .poweredOn:
            isBluetoothOn = true
        default:
            isBluetoothOn = false
        }
    }
}
