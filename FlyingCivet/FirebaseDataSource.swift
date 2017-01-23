import Firebase
import Foundation

class FirebaseDataSource {

    func parseMenuItems(rawValue: Array<Any>) -> [MenuItem] {
        return parseMenuItems(rawValue: rawValue as NSArray)
    }

    func parseMenuItems(rawValue: NSArray) -> [MenuItem] {
        return rawValue.reduce([]) { acc, rawValue in
            let castedRawValue = rawValue as! Dictionary<String, Any>
            return acc + [MenuItem(rawValue: castedRawValue)]
        }
    }

    func getMenuItems(completionBlock block: @escaping ([MenuItem]) -> ()) {
        let database = FIRDatabase.database()
        database.reference().child("items").observe(.value, with: { snapshot in
            let items = self.parseMenuItems(rawValue: snapshot.value as! NSArray)
            block(items)
        })
    }
    
}
