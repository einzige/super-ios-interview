import Foundation

class BaseModel {
    var data: [String: AnyObject]
    
    init(data: [String: AnyObject]) {
        self.data = data
        afterInit()
    }
    
    subscript(key: String) -> AnyObject? {
        get {
            return data[key]
        }
        set(newValue) {
            data[key] = newValue
        }
    }
    
    var ID: Int {
        get { return self["id"] as Int }
    }
    
    func afterInit() {
        // Override me
    }
}