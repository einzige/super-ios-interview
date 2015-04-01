import Foundation

class Logger {
    // NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]
    
    func info(str: String) {
        if globals.mode == Environment.Development {
            NSLog("%@", str)
        }
    }
}