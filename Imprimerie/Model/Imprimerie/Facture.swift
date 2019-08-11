//
//  Facture.swift
//  Imprimerie
//
//  Created by MAC on 8/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Facture class
class Facture: NSManagedObject {
  // Retrieve data
  static var all: [Facture] {
    let request: NSFetchRequest<Facture> = Facture.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "date", ascending: true),
      NSSortDescriptor(key: "client", ascending: true)
    ]
    guard let factures = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return factures
  }

  // Calculated fields
  var annee: String { return date?.yearToString() ?? "" }
  var mois: String { return date?.monthToString() ?? "" }
  var solde: Double { return montant - reglements}

  // Count data
  static var count: Int {
    let request: NSFetchRequest<Facture> = Facture.fetchRequest()
    guard let count = try? AppDelegate.viewContext.count(for: request) else { return 0 }
    return count
  }
  
}
