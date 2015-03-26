import Foundation

class Post: BaseModel {
    var title: String {
        set(newVal) {
            self["title"] = newVal
        }
        get {
            if self["title"] != nil {
                return self["title"] as String
            } else {
                return self.createdAt
            }
        }
    }
    
    var message: String? {
        set(newVal) { self["message"] = newVal }
        get {
            return self["message"] as? String
        }
    }
    
    var createdAt: String {
        get { return self["created_at"] as String }
    }
    
    var likes_count: Int {
        get { return self["likes_count"] as Int }
    }
}