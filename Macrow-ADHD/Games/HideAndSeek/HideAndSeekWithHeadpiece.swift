//
//  HideAndSeekWithHeadpiece.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/24/23.
//

import Foundation

class HideAndSeekWithHeadpiece: HideAndSeekScene {
    private func handleMWMData(_ mwmData: MWMData) {
        // Update your UI or perform other actions with the received data
        print("Received MWMData: (Signal, Att, Med) \(mwmData.poorSignal), \(mwmData.attention), \(mwmData.meditation)")
        focusCount = Int(mwmData.attention)
        
        if signalStatus == 4 && !isCompleted{
            dataController.addFocus(value: Int16(self.focusCount), time: Date(), report: self.reportEntity, context: self.context)
            listFocusData.append(Double(focusCount))
        }
    }
    
    override func startMWMPublisher() {
        super.startMWMPublisher()
        mwmObject.mwmDataPublisher
            .sink { [weak self] mwmData in
                // Handle the emitted MWMData here
                self?.handleMWMData(mwmData)
                
            }
            .store(in: &cancellables)
        mwmObject.signalStatusPublisher
            .sink { signalStatus in
                self.signalStatus = signalStatus
                print("Signal: \(self.signalStatus)")
            }
            .store(in: &cancellables)
    }
    
    
    override func stopMWMPublisher() {
        cancellables.removeAll()
    }
}
