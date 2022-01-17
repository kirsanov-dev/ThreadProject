import Foundation

public var chipStorage = [Chip]()
public var condition = NSCondition()
public var isAvailable = false
public var counter = 1
public var timer = Timer()
public let interval = 2.0
public let deadline = 20.0
public let maxCounter = Int(deadline / interval)

public class Generator: Thread {
    public override func main() {
        timer = Timer(timeInterval: interval, repeats: true) { _ in
            condition.lock()
            chipStorage.append(Chip.make())
            print("Чип \(counter) добавен в хранилище.")
            counter += 1
            isAvailable = true
            condition.signal()
            condition.unlock()
            if counter > maxCounter {
                timer.invalidate()
                Thread.current.cancel()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }
}

public class Worker: Thread {
    public override func main() {
        for _ in 1...maxCounter {
            while (!isAvailable) {
                condition.wait()
            }
            let lastChip = chipStorage.removeLast()
            condition.signal()
            condition.unlock()
            lastChip.soldering()
            print("Чип припаян.")
            if chipStorage.count < 1 {
                isAvailable = false
            }
        }
    }
}
