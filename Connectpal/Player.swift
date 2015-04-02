import UIKit
import AVFoundation

@objc protocol PlayableDelegate: NSObjectProtocol {
    optional func onPlayerFailure()
    optional func beforeAudioLoad()
    optional func onPlay()
    optional func onFinishedPlaying()
    optional func onStoppedPlaying()
    optional func onPause()
}

class Player: AVPlayer, AVAudioPlayerDelegate {
    var currentPosition: Float = 0.0
    var delegate: PlayableDelegate?
    var playing: Bool {
        return rate > 0 && error == nil
    }
    
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
                delegate?.onPlayerFailure?()
            } else if status == AVPlayerStatus.ReadyToPlay {
                play(position: currentPosition)
            } else if status == AVPlayerStatus.Unknown {
                globals.logger.info("Player status changed to unknown")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if flag {
            delegate?.onFinishedPlaying?()
        } else {
            delegate?.onStoppedPlaying?()
        }
    }
    
    override func pause() {
        println("PAUSE")
        super.pause()
        delegate?.onPause?()
    }
    
    override func play() {
        play(position: currentPosition)
    }
    
    func play(item: AVPlayerItem) {
        super.pause()
        currentPosition = 0.0
        observeItem(item)
    }

    func play(position: Float = 0.0) {
        super.pause()
        currentPosition = position
        
        if status == AVPlayerStatus.ReadyToPlay {
            if currentItem != nil {
                if currentItem.status == AVPlayerItemStatus.ReadyToPlay {
                    println("PLAY")
                    delegate?.onPlay?()
                    //globals.logger.info("Playing \(currentItem)")
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
        delegate?.beforeAudioLoad?()
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
