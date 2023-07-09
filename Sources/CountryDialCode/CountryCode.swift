//
//  CountryCode.swift
//  
//
//  Created by Sreekuttan D on 09/07/23.
//

import Foundation

public struct CountryCode: Codable {
    public let name: String
    public let dialCode: String
    public let code: String

    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code
    }
    
    public var localizedName: String? {
        Locale.current.localizedString(forRegionCode: self.code)
    }
    
    public func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.code.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
}
