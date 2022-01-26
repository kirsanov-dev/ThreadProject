import Foundation

public class Storage {
    private var storage: [Chip] = []
    private var counter: Int = 0
    private let condition = NSCondition()
    public var isAvailable = false
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public init() {}
    
    func push(item: Chip) {
        condition.lock()
        storage.append(item)
        counter += 1
        print("Чип \(counter) добавлен в хранилище.")
        isAvailable = true
        condition.signal()
        condition.unlock()
    }
    
    func pop() -> Chip {
        while (!isAvailable) {
            condition.wait()
        }
        let lastChip = storage.removeLast()
        condition.signal()
        condition.unlock()
        if isEmpty {
           isAvailable = false
        }
        return lastChip
    }
}
