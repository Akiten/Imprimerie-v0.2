//
//  MasseSalariale.swift
//  Imprimerie
//
//  Created by MAC on 8/6/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - MasseSalariale class
class MasseSalariale: NSManagedObject {
  // Retrieve data
  static var all: [MasseSalariale] {
    let request: NSFetchRequest<MasseSalariale> = MasseSalariale.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "annee", ascending: true)]
    guard let massesSalariales = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return massesSalariales
  }

  // Calculated fields
  var annuelle: Double { return Double(mensuelle * 12) }    // Sur l'année
  var mensuelleMoyenne: Double { return Double((mensuelle * 13) / 12) }   // Mensuelle * 13 mois / 12 mois
  var journaliere: Double { return mensuelleMoyenne / Double (MainWindow.nbJoursTravaillesAnnee) }   // Par jour
  var horaire: Double { return Double(journaliere / 8) }    // Horaire

  // Count data
  static var count: Int {
    let request: NSFetchRequest<MasseSalariale> = MasseSalariale.fetchRequest()
    guard let count = try? AppDelegate.viewContext.count(for: request) else { return 0 }
    return count
  }

}
