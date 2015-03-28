import Foundation

class Post: BaseModel {
    override func afterInit() {
        self.message = self["message"] as? String // Force encoding via setter
    }

    var title: String? {
        set(newVal) { self["title"] = newVal }
        
        get {
            if self["title"] != nil {
                return self["title"] as? String
            } else {
                return self.createdAt
            }
        }
    }
    
    var message: String? {
        set(newVal) { self["message"] = newVal? }
        
        get {
            return self["message"]? as? String
        }
    }
    
    var createdAt: String {
        get { return self["created_at"] as String }
    }
    
    var likesCount: Int {
        get { return self["likes_count"] as Int }
    }
    
    var _user: User?
    
    var user: User? {
        set(newValue) { self._user = newValue }
        
        get {
            if _user != nil {
                return _user!
            } else {
                if self["user"] != nil {
                    self._user = User(data: self["user"] as [String: AnyObject])
                    return _user
                }
            }
            return nil
        }
    }
}