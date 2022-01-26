import Foundation

public class Storage {
    private var storage: [Chip] = []
    private var counter: Int = 0
    var isAvailable = false
    let condition = NSCondition()
    
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public init() {}
    
    func push() {
        storage.append(Chip.make())
        counter += 1
        print("Чип \(counter) добавлен в хранилище.")
    }
    
    func pop() -> Chip {
        return storage.removeLast()
    }
}
