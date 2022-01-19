import Foundation

public class Worker: Thread {
    var chipLimit: Int
    
    public init(chipLimit: Int) {
        self.chipLimit = chipLimit
    }
    
    public override func main() {
        for _ in 1...chipLimit {
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
