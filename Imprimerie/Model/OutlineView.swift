//
//  OutlineView.swift
//  Imprimerie
//
//  Created by MAC on 8/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

// MARK: - Structures
// Structure Detail
struct Detail {
  var name, icon, count: String
  
  init(_ name: String, _ icon: String, _ count: String) {
    self.name = name
    self.icon = icon
    self.count = count
  }
}

// Structure Section
struct Section {
  var name: String
  var detail: [Detail] = []

  init(_ name: String, _ detail: [Detail]) {
    self.name = name
    self.detail = detail
  }
}

// MARK: - Init outline View
func initOutlineView() -> [Section] {
  var section = [Section]()
  var detail = [Detail]()

  // Section Paramètres
  detail.append(Detail("Consommables", "NSActionTemplate", "1"))
  detail.append(Detail("Jours Travaillés", "NSActionTemplate", "2"))
  detail.append(Detail("Masse salariale", "NSActionTemplate", "3"))
  detail.append(Detail("Parutions", "NSActionTemplate", "4"))
  section.append(Section("PARAMETRES", detail))

  // Section Personnes
  detail.removeAll()
  detail.append(Detail("Clients", "NSTouchBarUserTemplate", "5"))
  detail.append(Detail("Fournisseurs", "NSTouchBarUserTemplate", "6"))
  detail.append(Detail("Salariés", "NSTouchBarUserTemplate", "7"))
  section.append(Section("PERSONNES", detail))

  // Section Imprimerie
  detail.removeAll()
  detail.append(Detail("Commandes", "NSTouchBarSidebarTemplate", "8"))
  detail.append(Detail("Etats de besoins", "NSTouchBarSidebarTemplate", "9"))
  detail.append(Detail("Facturation", "NSTouchBarSidebarTemplate", "10"))
  section.append(Section("IMPRIMERIE", detail))

  // Section Presse
  detail.removeAll()
  detail.append(Detail("Gâches", "NSScriptTemplate", "11"))
  detail.append(Detail("Tirages", "NSScriptTemplate", "12"))
  section.append(Section("PRESSE", detail))

  // Section Tableaux de bord
  detail.removeAll()
  detail.append(Detail("Quotidiens", "NSTouchBarBookmarksTemplate", "13"))
  detail.append(Detail("Mensuels", "NSTouchBarBookmarksTemplate", "14"))
  detail.append(Detail("Ventes de gâches", "NSTouchBarBookmarksTemplate", "15"))
  section.append(Section("TABLEAUX DE BORD", detail))

  return section
}
