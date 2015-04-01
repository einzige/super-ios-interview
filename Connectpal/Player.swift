import UIKit
import AVFoundation

class Player: AVPlayer {
    func addStatusObserver(observer: NSObject) {
        addObserver(observer, forKeyPath: "status", options: nil, context: nil)
    }
}
