//
//  Commande.swift
//  Imprimerie
//
//  Created by MAC on 8/8/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Commande class
class Commande: NSManagedObject {
  // Retrieve data
  static var all: [Commande] {
    let request: NSFetchRequest<Commande> = Commande.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "date", ascending: true),
      NSSortDescriptor(key: "fournisseur", ascending: true)
    ]
    guard let commandes = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return commandes
  }

  // Calculated fields
  var annee: String { return date?.yearToString() ?? "" }
  var mois: String { return date?.monthToString() ?? "" }
  var solde: Double { return montant - reglements}
}
