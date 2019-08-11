//
//  Parution.swift
//  Imprimerie
//
//  Created by MAC on 8/6/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Parution class
class Parution: NSManagedObject {
  // Retrieve data
  static var all: [Parution] {
    let request: NSFetchRequest<Parution> = Parution.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "parution", ascending: true)]
    guard let parutions = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return parutions
  }

  // Count data
  static var count: Int {
    let request: NSFetchRequest<Parution> = Parution.fetchRequest()
    guard let count = try? AppDelegate.viewContext.count(for: request) else { return 0 }
    return count
  }
}
