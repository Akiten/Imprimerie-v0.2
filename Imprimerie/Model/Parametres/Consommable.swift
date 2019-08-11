//
//  Consommable.swift
//  Imprimerie
//
//  Created by MAC on 8/4/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK: - Consommable class
class Consommable: NSManagedObject {
  // Retrieve data
  static var all: [Consommable] {
    let request: NSFetchRequest<Consommable> = Consommable.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "article", ascending: true)]
    guard let consommables = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return consommables
  }

  // Count data
  static var count: Int {
    let request: NSFetchRequest<Consommable> = Consommable.fetchRequest()
    guard let count = try? AppDelegate.viewContext.count(for: request) else { return 0 }
    return count
  }
}
