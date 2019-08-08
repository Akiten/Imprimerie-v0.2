//
//  EtatDeBesoin.swift
//  Imprimerie
//
//  Created by MAC on 8/8/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - EtatDeBesoin class
class EtatDeBesoin: NSManagedObject {
  // Retrieve data
  static var all: [EtatDeBesoin] {
    let request: NSFetchRequest<EtatDeBesoin> = EtatDeBesoin.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "date", ascending: true),
      NSSortDescriptor(key: "demandeur", ascending: true),
      NSSortDescriptor(key: "beneficiaire", ascending: true),
    ]
    guard let etatsDeBesoins = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return etatsDeBesoins
  }

  // Calculated fields
  var annee: String { return date?.yearToString() ?? "" }
  var mois: String { return date?.monthToString() ?? "" }
  var solde: Double { return mtDemande - mtDecaisse}
}
