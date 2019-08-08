//
//  EtatDeBesoinViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/8/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class EtatDeBesoinViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!

  // textFields
  @IBOutlet weak var dateTextField: NSTextField!
  @IBOutlet weak var designationTextField: NSTextField!
  @IBOutlet weak var demandeurComboBox: NSComboBox!
  @IBOutlet weak var beneficiaireComboBox: NSComboBox!
  @IBOutlet weak var mtDemandeTextField: NSTextField!
  @IBOutlet weak var mtDecaisseTextField: NSTextField!
  @IBOutlet weak var soldeTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  
  // Init
  var etatsDeBesoins = EtatDeBesoin.all    // getDate from entity

  // MARK: - View Controller functions

  override func viewDidLoad() {
      super.viewDidLoad()
      // Do view setup here.
  }

  override func viewWillAppear() {
    super.viewWillAppear()

    // Delegates
    tableView.dataSource = self
    tableView.delegate = self

    // Load datas in tableView
    tableView.reloadData()
  }

}

// MARK: - tableView dataSource
extension EtatDeBesoinViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return etatsDeBesoins.count
  }
}

// MARK: - tableView delegate
extension EtatDeBesoinViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "annee": textView?.string = etatsDeBesoins[row].annee
      case "mois": textView?.string = etatsDeBesoins[row].mois
      case "date": textView?.string = etatsDeBesoins[row].date?.dateToString() ?? ""
      case "designation": textView?.string = etatsDeBesoins[row].designation ?? ""
      case "demandeur": textView?.string = etatsDeBesoins[row].demandeur ?? ""
      case "beneficiaire": textView?.string = etatsDeBesoins[row].beneficiaire ?? ""
      case "mtDemande": textView?.string = String(etatsDeBesoins[row].mtDemande)
      case "mtDecaisse": textView?.string = String(etatsDeBesoins[row].mtDecaisse)
      case "solde": textView?.string = String(etatsDeBesoins[row].solde)
      case "commentaire": textView?.string = etatsDeBesoins[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}

