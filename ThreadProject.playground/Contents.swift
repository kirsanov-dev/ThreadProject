import UIKit

let storage = Storage()
let generator = Generator(for: storage)
let worker = Worker(for: storage)

generator.start()
worker.start()


