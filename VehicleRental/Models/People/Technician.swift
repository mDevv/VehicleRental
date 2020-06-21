//
//  Mechanic.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc
public enum TechnicianSpecialization: Int32 {
    case electronics    = 0
    case mechanics      = 1
    case vulcanization  = 2
}

@objc(Technician)
public class Technician: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Technician> {
        return NSFetchRequest<Technician>(entityName: "Technician")
    }
    
    public static var all: [Technician] = []
    
    // MARK: - Attributes
    
    @NSManaged var specialization: TechnicianSpecialization
    
    @NSManaged var employee: Employee?
    @NSManaged var services: Set<Service>?
    
    // MARK: - CoreData helpers
    
    @objc(addServicesObject:)
    @NSManaged public func addToServices(_ value: Service)
    
    @objc(removeServicesObject:)
    @NSManaged public func removeFromServices(_ value: Service)
    
    @objc(addServices:)
    @NSManaged public func addToServices(_ values: Set<Service>)
    
    @objc(removeServices:)
    @NSManaged public func removeFromServices(_ values: Set<Service>)
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext, specialization: TechnicianSpecialization) {
        let description = NSEntityDescription.entity(forEntityName: "Technician", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.specialization = specialization
    }
    
    // MARK: - Helpers
    
    public func delete(context: NSManagedObjectContext) {
        self.removeFromAll()
        for service in services! {
            service.removeFromAll()
        }
        
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Business logic
    
    /// Enter the information about the vehicle servicing
    public func enterServiceData() {
        // TODO(mDevv): Implement me.
    }
}
