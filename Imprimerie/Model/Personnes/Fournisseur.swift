//
//  Fournisseur.swift
//  Imprimerie
//
//  Created by MAC on 8/7/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Fournisseur class
class Fournisseur: NSManagedObject {
  // Retrieve data
  static var all: [Fournisseur] {
    let request: NSFetchRequest<Fournisseur> = Fournisseur.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "fournisseur", ascending: true)]
    guard let fournisseurs = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return fournisseurs
  }

  // Calculated fields
  var solde: Double { return facturation - reglements}
}
