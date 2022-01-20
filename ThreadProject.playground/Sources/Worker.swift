import Foundation

public class Worker: Thread {
    var chipStorage: ChipStorage
    
    public init(for chipStorage: ChipStorage) {
        self.chipStorage = chipStorage
    }
    
    public override func main() {
        while true {
            while (!self.chipStorage.isAvailable) {
                self.chipStorage.condition.wait()
            }
            let lastChip = self.chipStorage.storage.removeLast()
            self.chipStorage.condition.signal()
            self.chipStorage.condition.unlock()
            lastChip.soldering()
            print("Чип припаян.")
            if self.chipStorage.storage.count < 1 {
                self.chipStorage.isAvailable = false
            }
        }
    }
}
