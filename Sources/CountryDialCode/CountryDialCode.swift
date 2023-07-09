
import Foundation

public struct CountryDialCode {
    
    public init() {
        
    }
    
    public static func getAllCodes() -> [CountryCode] {
        return Bundle.countryDialCode.decode(Array<CountryCode>.self, from: "CountryCodes.json")
    }
    
    public static func current() -> CountryCode? {
        
        var locale: String? = ""
        
        if #available(iOS 16, *)  {
            locale = Locale.current.region?.identifier
        } else {
            locale = Locale.current.regionCode
        }
        return getAllCodes().first(where: { $0.code == locale })
    }
}
