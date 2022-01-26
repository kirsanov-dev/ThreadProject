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
        timer = Timer(timeInterval: interval, repeats: true) { [unowned self] _ in
            self.storage.push(item: Chip.make())
        }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run(until: Date.init(timeIntervalSinceNow: deadline))
    }
}


