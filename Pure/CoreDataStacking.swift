//
//  CoreDataStacking.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation
import CoreData

protocol CoreDataStacking {
    var container: NSPersistentContainer { get }
}

extension CoreDataStacking {
    var context: NSManagedObjectContext { container.viewContext }
    
    func saveContext() {
        if context.hasChanges { do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        } }
    }
    
    func create(_ entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: container.viewContext)
    }
    
    func readAll(_ entityName: String, sorts: [NSSortDescriptor], pred: NSPredicate? = nil) throws -> [NSFetchRequestResult] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.sortDescriptors = sorts
        request.predicate = pred
        return try container.viewContext.fetch(request)
    }
    
    func readAll<Root: NSManagedObject, Value>(sortKey: KeyPath<Root, Value>, ascending: Bool = true) throws -> [Root] {
        let request: NSFetchRequest<Root> = Root.fetchRequest() as! NSFetchRequest<Root>
        let sortByName = NSSortDescriptor(keyPath: sortKey, ascending: ascending)
        request.sortDescriptors = [sortByName]
        return try container.viewContext.fetch(request)
    }
    
    func readFirst(_ entityName: String, pred: NSPredicate) throws -> NSFetchRequestResult? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = pred
        request.fetchLimit = 1
        return try container.viewContext.fetch(request).first
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    func deleteAll(_ request: NSFetchRequest<some NSFetchRequestResult>) throws -> NSPersistentStoreResult {
        let delReq = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        return try context.execute(delReq)
    }
    
    func count(for request: NSFetchRequest<NSFetchRequestResult>) throws -> Int {
        return try context.count(for: request)
    }
    
}


extension NSPersistentContainer {
    convenience init(store: String, inMemory: Bool = false) {
        self.init(name: store)
        #if DEBUG
        let inMemory = ProcessInfo.isPreviewMode  // force inMemory mode
        #endif
        if inMemory {
            self.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        self.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        self.viewContext.automaticallyMergesChangesFromParent = true
    }
}


#if DEBUG
private extension ProcessInfo {
    static var isPreviewMode: Bool {
        processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
#endif
