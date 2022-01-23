import Foundation

public class Generator: Thread {
    private var timer = Timer()
    private let interval = 2.0
    private let deadline = 20.0
    private var storage: Storage
    
    public init(for storage: Storage) {
        self.storage = storage
    }
    
    public override func main() {
        timer = Timer(timeInterval: interval, repeats: true) { _ in
            self.storage.condition.lock()
            self.storage.push()
            self.storage.isAvailable = true
            self.storage.condition.signal()
            self.storage.condition.unlock()
        }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run(until: Date.init(timeIntervalSinceNow: deadline))
    }
}


