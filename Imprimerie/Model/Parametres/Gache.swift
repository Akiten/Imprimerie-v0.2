//
//  Gache.swift
//  Imprimerie
//
//  Created by MAC on 8/13/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Gache class
class Gache: NSManagedObject {
  // Retrieve data
  static var all: [Gache] {
    let request: NSFetchRequest<Gache> = Gache.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "gache", ascending: true)]
    guard let gaches = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return gaches
  }

  // Count data
  static var count: Int {
    let request: NSFetchRequest<Gache> = Gache.fetchRequest()
    guard let count = try? AppDelegate.viewContext.count(for: request) else { return 0 }
    return count
  }
}
