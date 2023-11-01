//
//  MWMModel.swift
//  MacroADHD-simulator
//
//  Created by Gregorius Yuristama Nugraha on 10/25/23.
//

import Foundation


class MWMModel: Identifiable, Hashable {
    static func == (lhs: MWMModel, rhs: MWMModel) -> Bool {
        return lhs.devName == rhs.devName &&
               lhs.mfgID == rhs.mfgID &&
               lhs.deviceID == rhs.deviceID
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(devName)
        hasher.combine(mfgID)
        hasher.combine(deviceID)
    }
    
    
    let devName: String
    let mfgID: String
    let deviceID: String
    
    init(devName: String, mfgID: String, deviceID: String) {
        self.devName = devName
        self.mfgID = mfgID
        self.deviceID = deviceID
    }
    
}
