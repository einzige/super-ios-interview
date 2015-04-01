import UIKit
import AVFoundation

class Player: AVPlayer, AVAudioPlayerDelegate {
    var currentPosition: Float = 0.0
    
    override init() {
        super.init()
        addStatusObserver(self)
    }
    
    override init(playerItem item: AVPlayerItem!) {
        super.init(playerItem: item)
        addStatusObserver(self)
        observeItem(item)
    }
    
    func addStatusObserver(observer: NSObject) {
        addObserver(observer, forKeyPath: "status", options: nil, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "status" {
            if status == AVPlayerStatus.Failed {
                globals.logger.info("Failed to initialize the player")
            } else {
                play(position: currentPosition)
            }
        }
    }
    
    func play(item: AVPlayerItem) {
        currentPosition = 0.0
        observeItem(item)
    }

    func play(position: Float = 0.0) {
        pause()
        currentPosition = position
        
        if status == AVPlayerStatus.ReadyToPlay {
            if currentItem != nil {
                if currentItem.status == AVPlayerItemStatus.ReadyToPlay {
                    globals.logger.info("Playing \(currentItem)")
                    seekToTime(getSeekTime())
                    super.play()
                } else {
                    if currentItem.status == AVPlayerItemStatus.Failed {
                        globals.logger.info("Audio item failed")
                    }
                    globals.logger.info("Audio item is not ready yet")
                }
            } else {
                globals.logger.info("Current item is nil")
            }
        } else {
            globals.logger.info("Player is not ready")
        }
    }
    
    private func observeItem(item: AVPlayerItem) {
        replaceCurrentItemWithPlayerItem(item)
        item.addObserver(self, forKeyPath: "status", options: nil, context: nil)
    }
    
    private func getSeekTime() -> CMTime {
        let currentItemDuration = currentItem!.duration
        let duration = CMTimeGetSeconds(currentItemDuration)
        let seekPosition = duration * Float64(currentPosition)
        
        return CMTimeMakeWithSeconds(seekPosition, currentItemDuration.timescale)
    }
}
