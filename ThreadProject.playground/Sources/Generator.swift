import Foundation

public var chipStorage = [Chip]()
public var condition = NSCondition()
public var isAvailable = false

public class Generator: Thread {
    var timer = Timer()
    let interval = 2.0
    public static let chipLimit: Int = 10
    
    public override func main() {
        var counter = 1
        timer = Timer(timeInterval: interval, repeats: true) { _ in
            condition.lock()
            chipStorage.append(Chip.make())
            print("Чип \(counter) добавен в хранилище.")
            counter += 1
            isAvailable = true
            condition.signal()
            condition.unlock()
            if counter > Generator.chipLimit {
                self.timer.invalidate()
                Thread.current.cancel()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }
}


