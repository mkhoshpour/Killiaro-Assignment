//
//  DataBaseManager.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 2/2/22.
//

import UIKit
import CoreData

typealias Completion = (() -> Void)?
typealias ErrorHandler = ((String) -> Void)?

class DataBaseManager {

    public static func deleteAllMedia() {
        // Specify a batch to delete with a fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "MediaEntity")

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: fetchRequest
        )

        deleteRequest.resultType = .resultTypeObjectIDs

        // Get a reference to a managed object context
        let context = appDelegate.persistentContainer.viewContext

        // Perform the batch delete
        guard let  batchDelete = try? context.execute(deleteRequest)
                as? NSBatchDeleteResult else { return }

        guard let deleteResult = batchDelete.result
            as? [NSManagedObjectID]
            else { return }

        let deletedObjects: [AnyHashable: Any] = [
            NSDeletedObjectsKey: deleteResult
        ]

        // Merge the delete changes into the managed
        // object context
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [context]
        )
    }

    public static func saveMedia(media: MediaModel, completion: Completion, saveError: ErrorHandler) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        // 1
        let managedContext = appDelegate.persistentContainer.viewContext

        // 2
        let entity = NSEntityDescription.entity(forEntityName: "MediaEntity", in: managedContext)!
        let mediaModel = NSManagedObject(entity: entity, insertInto: managedContext)

        // 3
        mediaModel.setValue(media.id, forKey: "id")
        mediaModel.setValue(media.download_url, forKey: "download_url")
        mediaModel.setValue(media.thumbnail_url, forKey: "thumbnail_url")
        mediaModel.setValue(media.filename, forKey: "filename")
        mediaModel.setValue(media.size, forKey: "size")
        mediaModel.setValue(media.content_type, forKey: "content_type")
        mediaModel.setValue(media.created_at, forKey: "created_at")
        mediaModel.setValue(media.content_type, forKey: "content_type")
        mediaModel.setValue(media.md5sum, forKey: "md5sum")
        mediaModel.setValue(media.resx, forKey: "resx")
        mediaModel.setValue(media.resy, forKey: "resy")
        mediaModel.setValue(media.taken_at, forKey: "taken_at")
        mediaModel.setValue(media.user_id, forKey: "user_id")

        // 4
        do {
            try managedContext.save()
            completion?()
        } catch let error as NSError {
            saveError?("Could not save. \(error), \(error.userInfo)")
        }
    }

    public static func fetchAllMedias() -> [MediaModel]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}

        // 1
        let managedContext = appDelegate.persistentContainer.viewContext

        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MediaEntity")

        // 3
        do {
            let objects = try managedContext.fetch(fetchRequest)
            if !objects.isEmpty {
                return DataBaseManager().mapManagedObjectToModel(objects: objects)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }

        return nil
    }

    private func mapManagedObjectToModel(objects: [NSManagedObject]) -> [MediaModel]? {

        var medias = [MediaModel]()

        objects.forEach { object in

            let media = MediaModel(id: object.value(forKey: "id") as? String, content_type: object.value(forKey: "content_type") as? String, created_at: object.value(forKey: "created_at") as? Date, download_url: object.value(forKey: "download_url") as? String, filename: object.value(forKey: "filename") as? String, md5sum: object.value(forKey: "md5sum") as? String, media_type: object.value(forKey: "media_type") as? String, resx: object.value(forKey: "resx") as? Int64, resy: object.value(forKey: "resy") as? Int64, size: object.value(forKey: "size") as? Int64, taken_at: object.value(forKey: "taken_at") as? Date, thumbnail_url: object.value(forKey: "thumbnail_url") as? String, user_id: object.value(forKey: "user_id") as? String)

            medias.append(media)

        }

        return medias

    }

}
