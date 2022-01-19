import UIKit

let generator = Generator()
let worker = Worker(chipLimit: Generator.chipLimit)

worker.start()
generator.start()
