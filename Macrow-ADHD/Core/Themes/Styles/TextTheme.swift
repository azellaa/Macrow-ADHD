//
//  TextTheme.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import Foundation
import SwiftUI

extension Font {
    struct Heading {
        static let heading1 = custom(AppFont.juaRegular, size: Decimal.double86)
        static let heading2 = custom(AppFont.juaRegular, size: Decimal.double72)
    }
    struct SubHeading{
        static let subHeading1 = custom(AppFont.juaRegular, size: Decimal.double32)
        static let subHeading2 = custom(AppFont.juaRegular, size: Decimal.double28)
    }
    struct Body {
        static let body1 = custom(AppFont.juaRegular, size: Decimal.double24)
        static let body2 = custom(AppFont.juaRegular, size: Decimal.double20)
    }
    struct Caption {
        static let caption1 = custom(AppFont.juaRegular, size: Decimal.double14)
    }
}
