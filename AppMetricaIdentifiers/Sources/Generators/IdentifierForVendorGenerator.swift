#if os(macOS)
import AppKit
#else
import UIKit
#endif

final class IdentifierForVendorGenerator: DeviceIDGenerator {
    
    func generateDeviceID() -> DeviceID? {
#if os(macOS)
		let uuid: String? = nil
#else
		let uuid = UIDevice.current.identifierForVendor?.uuidString
#endif
        return uuid.map { DeviceID(nonEmptyString: $0) }
    }
    
}
