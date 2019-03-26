
import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var name: String?
    @NSManaged public var pic: NSData?

}
