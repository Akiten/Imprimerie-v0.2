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
  detail.append(Detail("Consommables", "NSActionTemplate", "0"))
  detail.append(Detail("Gâche", "NSActionTemplate", "0"))
  detail.append(Detail("Jours travaillés", "NSActionTemplate", "0"))
  detail.append(Detail("Matières premières", "NSActionTemplate", "0"))
  detail.append(Detail("Masse salariale", "NSActionTemplate", "0"))
  detail.append(Detail("Parutions", "NSActionTemplate", "0"))
  section.append(Section("PARAMETRES", detail))

  // Section Personnes
  detail.removeAll()
  detail.append(Detail("Clients", "NSTouchBarUserTemplate", "0"))
  detail.append(Detail("Fournisseurs", "NSTouchBarUserTemplate", "0"))
  detail.append(Detail("Salariés", "NSTouchBarUserTemplate", "0"))
  section.append(Section("PERSONNES", detail))

  // Section Imprimerie
  detail.removeAll()
  detail.append(Detail("Commandes", "NSTouchBarSidebarTemplate", "0"))
  detail.append(Detail("Etats de besoins", "NSTouchBarSidebarTemplate", "0"))
  detail.append(Detail("Facturation", "NSTouchBarSidebarTemplate", "0"))
  section.append(Section("IMPRIMERIE", detail))

  // Section Presse
  detail.removeAll()
  detail.append(Detail("Ventes de gâches", "NSScriptTemplate", "0"))
  detail.append(Detail("Tirages Gazette", "NSScriptTemplate", "0"))
  section.append(Section("PRESSE", detail))

  // Section Tableaux de bord
  detail.removeAll()
  detail.append(Detail("Rapport quotidien", "NSTouchBarBookmarksTemplate", "0"))
  detail.append(Detail("Synthèse Mensuelle", "NSTouchBarBookmarksTemplate", "0"))
  detail.append(Detail("Synthèse ventes de gâches", "NSTouchBarBookmarksTemplate", "0"))
  section.append(Section("TABLEAUX DE BORD", detail))

  return section
}
