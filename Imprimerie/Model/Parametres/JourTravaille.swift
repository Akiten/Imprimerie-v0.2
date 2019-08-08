//
//  JourTravaille.swift
//  Imprimerie
//
//  Created by MAC on 8/5/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import CoreData

// MARK: - JourTravaille class
class JourTravaille: NSManagedObject {
  // Retrieve data
  static var all: [JourTravaille] {
    let request: NSFetchRequest<JourTravaille> = JourTravaille.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "annee", ascending: true)]
    guard let joursTravailles = try? AppDelegate.viewContext.fetch(request) else { return [] }
    return joursTravailles
  }

  // Calculated fields
  var nbJoursTravailles: Int { return Int(nbJoursOuvres - nbJoursFeries) }
}
