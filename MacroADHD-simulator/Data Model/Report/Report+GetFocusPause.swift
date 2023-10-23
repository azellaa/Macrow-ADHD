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
}
