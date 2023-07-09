# CountryDialCode

CountryDialCode is a light weight package to add different phone number dial codes to your application.



## Requirements


1. Xcode 12.1 or later
2. iOS 11 or later
3. macOS 10_13 or later
4. tvOS 11 or later
5. watchOS 4 or later


## Installation

Setting up with [Swift Package Manager](https://swiftpm.co/?query=PhoneNumberKit)

From Xcode 11+ :

1. Select File -> Swift Packages -> Add Package Dependency. Enter `https://github.com/kuttz/CountryDialCode` in the "Choose Package Repository" dialog.
2. In the next page, specify the version resolving rule.
3. After Xcode checked out the source and resolving the version, you can choose the "CountryDialCode" library and add it to your app target.

**-OR-**

Alternatively, you can also add CountryDialCode to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kuttz/CountryDialCode", from: "1.0.0")
]
```

For more info, read [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) from Apple.
