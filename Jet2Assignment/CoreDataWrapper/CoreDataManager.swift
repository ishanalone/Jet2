//
//  CoreDataManager.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Container {
    
    let context : NSManagedObjectContext?
    
    init(_ context : NSManagedObjectContext) {
        self.context = context
    }
    
    func save() {
        if let context = context{
            if context.hasChanges{
                do {
                    try self.context?.save()
                }catch let error as NSError{
                    print(error)
                }
            }
        }
    }
    
    func fetchData(of classObject: NSManagedObject.Type, with predicate:NSPredicate? ) -> [NSManagedObject]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: classObject.className())
        fetchRequest.predicate = predicate
        do{
            let result = try self.context?.fetch(fetchRequest)
            return result
            
        }
        catch let error as NSError{
            print(error)
        }
        return nil
    }
    
}

