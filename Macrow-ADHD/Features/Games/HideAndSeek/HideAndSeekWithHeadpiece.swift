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
                
                if !self.isSavingDisconnectData && self.signalStatus != 4 {
                    self.disconnectDataEntity = self.dataController.addDisconnect(startTime: Date(), report: self.reportEntity, context: self.context)
                    self.isSavingDisconnectData = true
                } else if self.isSavingDisconnectData && self.signalStatus == 4 {
                    self.dataController.editDisconnectEndTime(disconnect: self.disconnectDataEntity, endTime: Date(), context: self.context)
                    self.isSavingDisconnectData = false
                }
                
                switch signalStatus {
                case 1:
//                    self?.headpieceStatus.texture = self?.updateIcon("poorSignalIcon")
                    self.showPopupConnecting()
                case 2:
//                    self?.headpieceStatus.texture = self?.updateIcon("weakSignalIcon")
                    self.showPopupConnecting()
                case 3:
//                    self?.headpieceStatus.texture = self?.updateIcon("connectingIcon")
                    self.showPopupConnecting()
                case 4:
//                    self?.headpieceStatus.texture = self?.updateIcon("connectedIcon")
                    self.hidePopupAnimation()
                default:
//                    self?.headpieceStatus.texture = self?.updateIcon("noSignalIcon")
                    self.showPopupDisconnect()
                }
            }
            .store(in: &cancellables)
    }
    
    
    override func stopMWMPublisher() {
        cancellables.removeAll()
    }
}
