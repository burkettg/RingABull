import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "BackGroundImageV4" asset catalog image resource.
    static let backGroundImageV4 = DeveloperToolsSupport.ImageResource(name: "BackGroundImageV4", bundle: resourceBundle)

    /// The "GameMode00" asset catalog image resource.
    static let gameMode00 = DeveloperToolsSupport.ImageResource(name: "GameMode00", bundle: resourceBundle)

    /// The "bostonFernImage" asset catalog image resource.
    static let bostonFern = DeveloperToolsSupport.ImageResource(name: "bostonFernImage", bundle: resourceBundle)

    /// The "bricksWorn" asset catalog image resource.
    static let bricksWorn = DeveloperToolsSupport.ImageResource(name: "bricksWorn", bundle: resourceBundle)

    /// The "decorPot" asset catalog image resource.
    static let decorPot = DeveloperToolsSupport.ImageResource(name: "decorPot", bundle: resourceBundle)

    /// The "dirtFloor" asset catalog image resource.
    static let dirtFloor = DeveloperToolsSupport.ImageResource(name: "dirtFloor", bundle: resourceBundle)

    /// The "metalGrates" asset catalog image resource.
    static let metalGrates = DeveloperToolsSupport.ImageResource(name: "metalGrates", bundle: resourceBundle)

    /// The "metalRusty" asset catalog image resource.
    static let metalRusty = DeveloperToolsSupport.ImageResource(name: "metalRusty", bundle: resourceBundle)

    /// The "planksDark" asset catalog image resource.
    static let planksDark = DeveloperToolsSupport.ImageResource(name: "planksDark", bundle: resourceBundle)

    /// The "planksGray" asset catalog image resource.
    static let planksGray = DeveloperToolsSupport.ImageResource(name: "planksGray", bundle: resourceBundle)

    /// The "shutterRusted" asset catalog image resource.
    static let shutterRusted = DeveloperToolsSupport.ImageResource(name: "shutterRusted", bundle: resourceBundle)

    /// The "tilesAqua" asset catalog image resource.
    static let tilesAqua = DeveloperToolsSupport.ImageResource(name: "tilesAqua", bundle: resourceBundle)

    /// The "woodWeathered" asset catalog image resource.
    static let woodWeathered = DeveloperToolsSupport.ImageResource(name: "woodWeathered", bundle: resourceBundle)

    /// The "woodWorn" asset catalog image resource.
    static let woodWorn = DeveloperToolsSupport.ImageResource(name: "woodWorn", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "BackGroundImageV4" asset catalog image.
    static var backGroundImageV4: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .backGroundImageV4)
#else
        .init()
#endif
    }

    /// The "GameMode00" asset catalog image.
    static var gameMode00: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .gameMode00)
#else
        .init()
#endif
    }

    /// The "bostonFernImage" asset catalog image.
    static var bostonFern: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bostonFern)
#else
        .init()
#endif
    }

    /// The "bricksWorn" asset catalog image.
    static var bricksWorn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bricksWorn)
#else
        .init()
#endif
    }

    /// The "decorPot" asset catalog image.
    static var decorPot: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .decorPot)
#else
        .init()
#endif
    }

    /// The "dirtFloor" asset catalog image.
    static var dirtFloor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .dirtFloor)
#else
        .init()
#endif
    }

    /// The "metalGrates" asset catalog image.
    static var metalGrates: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .metalGrates)
#else
        .init()
#endif
    }

    /// The "metalRusty" asset catalog image.
    static var metalRusty: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .metalRusty)
#else
        .init()
#endif
    }

    /// The "planksDark" asset catalog image.
    static var planksDark: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .planksDark)
#else
        .init()
#endif
    }

    /// The "planksGray" asset catalog image.
    static var planksGray: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .planksGray)
#else
        .init()
#endif
    }

    /// The "shutterRusted" asset catalog image.
    static var shutterRusted: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shutterRusted)
#else
        .init()
#endif
    }

    /// The "tilesAqua" asset catalog image.
    static var tilesAqua: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tilesAqua)
#else
        .init()
#endif
    }

    /// The "woodWeathered" asset catalog image.
    static var woodWeathered: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .woodWeathered)
#else
        .init()
#endif
    }

    /// The "woodWorn" asset catalog image.
    static var woodWorn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .woodWorn)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "BackGroundImageV4" asset catalog image.
    static var backGroundImageV4: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .backGroundImageV4)
#else
        .init()
#endif
    }

    /// The "GameMode00" asset catalog image.
    static var gameMode00: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .gameMode00)
#else
        .init()
#endif
    }

    /// The "bostonFernImage" asset catalog image.
    static var bostonFern: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bostonFern)
#else
        .init()
#endif
    }

    /// The "bricksWorn" asset catalog image.
    static var bricksWorn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bricksWorn)
#else
        .init()
#endif
    }

    /// The "decorPot" asset catalog image.
    static var decorPot: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .decorPot)
#else
        .init()
#endif
    }

    /// The "dirtFloor" asset catalog image.
    static var dirtFloor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .dirtFloor)
#else
        .init()
#endif
    }

    /// The "metalGrates" asset catalog image.
    static var metalGrates: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .metalGrates)
#else
        .init()
#endif
    }

    /// The "metalRusty" asset catalog image.
    static var metalRusty: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .metalRusty)
#else
        .init()
#endif
    }

    /// The "planksDark" asset catalog image.
    static var planksDark: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .planksDark)
#else
        .init()
#endif
    }

    /// The "planksGray" asset catalog image.
    static var planksGray: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .planksGray)
#else
        .init()
#endif
    }

    /// The "shutterRusted" asset catalog image.
    static var shutterRusted: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shutterRusted)
#else
        .init()
#endif
    }

    /// The "tilesAqua" asset catalog image.
    static var tilesAqua: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tilesAqua)
#else
        .init()
#endif
    }

    /// The "woodWeathered" asset catalog image.
    static var woodWeathered: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .woodWeathered)
#else
        .init()
#endif
    }

    /// The "woodWorn" asset catalog image.
    static var woodWorn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .woodWorn)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

