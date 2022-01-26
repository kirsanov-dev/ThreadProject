import Foundation

public class Worker: Thread {
    private var storage: Storage
    
    public init(for storage: Storage) {
        self.storage = storage
    }
    
    public override func main() {
        repeat {
            let lastChip = self.storage.pop()
            lastChip.soldering()
            print("Чип припаян.")
        } while storage.isAvailable || storage.isEmpty
    }
}
