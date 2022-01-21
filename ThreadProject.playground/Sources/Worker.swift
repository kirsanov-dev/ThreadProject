import Foundation

public class Worker: Thread {
    private var storage: Storage
    
    public init(for storage: Storage) {
        self.storage = storage
    }
    
    public override func main() {
        while true {
            while (!self.storage.isAvailable) {
                self.storage.condition.wait()
            }
            let lastChip = self.storage.pop()
            self.storage.condition.signal()
            self.storage.condition.unlock()
            lastChip.soldering()
            print("Чип припаян.")
            if self.storage.isEmpty {
                self.storage.isAvailable = false
            }
        }
    }
}
