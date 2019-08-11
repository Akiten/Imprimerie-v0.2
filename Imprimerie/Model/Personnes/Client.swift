//
//  Client.swift
//  Imprimerie
//
//  Created by MAC on 8/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Client class
class Client: NSManagedObject {
  // Retrieve data
  static var all: [Client] {
    let request: NSFetchRequest<Client> = Client.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "client", ascending: true)]
    guard let clients = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return clients
  }

  // Calculated fields
  var solde: Double { return facturation - reglements}

  // Count data
  static var count: Int {
    let request: NSFetchRequest<Client> = Client.fetchRequest()
    guard let count = try? AppDelegate.viewContext.count(for: request) else { return 0 }
    return count
  }
}
