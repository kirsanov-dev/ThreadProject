import UIKit

let storage = Storage()
let generator = Generator(for: storage)
let worker = Worker(for: storage)

worker.start()
generator.start()
sleep(20)
generator.cancel()
if generator.isCancelled && storage.isEmpty {
    worker.cancel()
}
