import Foundation

public class Storage {
    private var storage: [Chip] = []
    var isAvailable = false
    let condition = NSCondition()
    
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public init() {}
    
    func push(value : Chip) {
        storage.append(value)
    }
    
    func pop() -> Chip {
        return storage.removeLast()
    }
}
