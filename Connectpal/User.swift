import Foundation

class User: BaseModel {
    
    var smallProfilePictureUrl: String? {
        get { return self["small_profile_picture_url"] as? String }
    }
}