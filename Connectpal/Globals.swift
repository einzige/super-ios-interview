import UIKit

enum Environment : Int {
    case Development
    case Production
    case Test
}

class Globals {
    lazy var player: Player = {
       return Player()
    }()
    
    var mode = Environment.Development
    
    lazy var logger: Logger = {
        return Logger()
    }()
}

let globals = Globals()
