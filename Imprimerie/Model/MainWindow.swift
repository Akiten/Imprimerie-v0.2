//
//  MainWindow.swift
//  Imprimerie
//
//  Created by MAC on 8/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

struct MainWindow {
  static let windowTitle = "Imprimerie v0.2.2"    // Window title
  static let currentMonth = Calendar.current.component(.month, from: Date())    // Current Month
  static let currentYear = Calendar.current.component(.year, from: Date())    // Current Year

  static let stringMonth = Date().monthToString()    // Month to string
  static let stringYear = Date().yearToString()    // Current string yerar

  static var nbJoursTravaillesAnnee = getNbJoursTravailles()   // For current year
  static var salaireJournalier = getSalaireJournalier()    // For current year
}

// Get nbJoursTravaillés
private func getNbJoursTravailles() -> Int {
  var nbJours = 0
  let joursTravailles = JourTravaille.all
  for jourTravaille in joursTravailles {
    if jourTravaille.annee == MainWindow.stringYear {
      nbJours = Int (jourTravaille.nbJoursOuvres) - Int (jourTravaille.nbJoursFeries)
    }
  }
  return nbJours
}

// Get salaireJournalier
private func getSalaireJournalier() -> Double {
  var salaire = 0.0
  let massesSalariales = MasseSalariale.all
  for masseSalariale in massesSalariales {
    if masseSalariale.annee == MainWindow.stringYear {
      let mensuelleMoyenne = Double ((masseSalariale.mensuelle * 13) / 12)
      salaire = mensuelleMoyenne / Double (MainWindow.nbJoursTravaillesAnnee)
    }
  }
  return salaire
}
