//
//  Report+Focuses.swift
//  Macrow-ADHD
//
//  Created by Ich on 23/10/23.
//

import Foundation

extension Report {
    
    public var focuses: [Focus] {
        let setOfFocuses = reportToFocus
        if let setOfFocuses = setOfFocuses {
            return setOfFocuses.sorted{
                $0.id > $1.id
            }
        } else {
            return []
        }
    }
    
    public var focusesSortedByTime: [Focus] {
        let setOfFocuses = reportToFocus
        if let setOfFocuses = setOfFocuses {
            return setOfFocuses.sorted{
                $0.time!.timeIntervalSince1970 < $1.time!.timeIntervalSince1970
            }
        } else {
            return []
        }
    }
    
    public var pauses: [Pause] {
        let setOfPauses = reportToPause
        
        if let setOfPauses = setOfPauses {
            return setOfPauses.sorted{
                $0.id > $1.id
            }
        } else {
            return []
        }
    }
    
    public var disconnects: [DisconnectEntity] {
        let setOfDisconnects = reportToDisconnect
        
        if let setOfDisconnects = setOfDisconnects {
            return setOfDisconnects.sorted{
                $0.id > $1.id
            }
        } else {
            return []
        }
    }
}

extension Report {
    public var getHighestFocus: Int16? {
        let setOfFocuses = reportToFocus
        if let setOfFocuses = setOfFocuses {
            return setOfFocuses.sorted(by: {$0.value > $1.value}).first?.value ?? 0
        }
        else {
            return nil
        }
    }
    
    public var getLowestFocus: Int16? {
        let setOfFocuses = reportToFocus
        if let setOfFocuses = setOfFocuses {
            return setOfFocuses.sorted(by: {$0.value < $1.value}).first?.value ?? 0
        }
        else {
            return nil
        }
    }
    public var getAverageFocus: Double? {
        let setOfFocuses = reportToFocus
        if let setOfFocuses = setOfFocuses {
            let totalFocus = setOfFocuses.reduce(0) { partialResult, nextResult in
                partialResult + Double(nextResult.value)
            }
            return totalFocus / Double(setOfFocuses.count)
        }
        else {
            return nil
        }
    }
    
    public var getPauseAccumulation: Double? {
        let setOfPauses = reportToPause
        if let setOfPauses = setOfPauses {
            var accumulation = 0.0
            for pause in setOfPauses {
                if let startTime = pause.startTime, let endTime = pause.endTime {
                    accumulation += endTime - startTime
                }
            }
            return accumulation
        }
        else {
            return nil
        }
    }
}
