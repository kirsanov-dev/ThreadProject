import Foundation

public class Generator: Thread {
    var timer = Timer()
    let interval = 2.0
    let deadline = 20.0
    var chipStorage: ChipStorage
    
    public init(for chipStorage: ChipStorage) {
        self.chipStorage = chipStorage
    }
    
    public override func main() {
        var counter = 0
        timer = Timer(timeInterval: interval, repeats: true) { _ in
            self.chipStorage.condition.lock()
            self.chipStorage.storage.append(Chip.make())
            counter += 1
            print("Чип \(counter) добавлен в хранилище.")
            self.chipStorage.isAvailable = true
            self.chipStorage.condition.signal()
            self.chipStorage.condition.unlock()
        }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run(until: Date.init(timeIntervalSinceNow: deadline))
    }
}


