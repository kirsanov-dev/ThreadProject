import Foundation

public class ChipStorage {
    var storage: [Chip] = []
    var isAvailable = false
    let condition = NSCondition()
    
    public init() {}
}
