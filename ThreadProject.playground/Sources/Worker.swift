import Foundation

public class Worker: Thread {
    private var storage: Storage
    
    public init(for storage: Storage) {
        self.storage = storage
    }
    
    public override func main() {
        while true {
            while (!storage.isAvailable) {
                storage.condition.wait()
            }
            let lastChip = self.storage.pop()
            storage.condition.signal()
            storage.condition.unlock()
            lastChip.soldering()
            print("Чип припаян.")
            if storage.isEmpty {
                storage.isAvailable = false
            }
        }
    }
}
