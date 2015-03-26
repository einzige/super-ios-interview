import Foundation

class BaseModel {
    var data: [String: AnyObject]
    
    init(data: [String: AnyObject]) {
        self.data = data
    }
    
    subscript(key: String) -> AnyObject? {
        get {
            return data[key]
        }
        set(newValue) {
            data[key] = newValue
        }
    }
}