//
//  Salarie.swift
//  Imprimerie
//
//  Created by MAC on 8/7/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK : - Salarie class
class Salarie: NSManagedObject {
  // Retrieve data
  static var all: [Salarie] {
    let request: NSFetchRequest<Salarie> = Salarie.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "nom", ascending: true),
      NSSortDescriptor(key: "prenom", ascending: true),
    ]
    guard let salaries = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return salaries
  }

  // Calculated fields
  var netAnnuel: Int { return Int(netMensuel * 12) }    // Sur l'année
  var netMensuelMoyen: Int { return Int((netMensuel * 13) / 12) }   // Mensuelle * 13 mois / 12 mois
  var netJournalier: Int { return Int(netMensuelMoyen / MainWindow.nbJoursTravaillesAnnee) }   // Par jour
  var netHoraire: Int { return Int(netJournalier / 8) }    // Horaire
}
