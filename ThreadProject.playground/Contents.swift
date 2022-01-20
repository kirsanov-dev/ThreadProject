import UIKit

let chipStorage = ChipStorage()
let generator = Generator(for: chipStorage)
let worker = Worker(for: chipStorage)

worker.start()
generator.start()
