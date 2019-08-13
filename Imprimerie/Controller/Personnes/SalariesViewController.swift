//
//  SalariesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/7/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class SalariesViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveTemplateSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var saveSegmentedControl: NSSegmentedControl!
  
  // textFields
  @IBOutlet weak var salarieTextField: NSTextField!
  @IBOutlet weak var nomTextField: NSTextField!
  @IBOutlet weak var prenomTextField: NSTextField!
  @IBOutlet weak var netMensuelTextField: NSTextField!
  @IBOutlet weak var netMensuelMoyenTextField: NSTextField!
  @IBOutlet weak var netJournalierTextField: NSTextField!
  @IBOutlet weak var netHoraireTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  @IBOutlet weak var serviceComboBox: NSComboBox!
  @IBOutlet weak var fonctionComboBox: NSComboBox!
  @IBOutlet weak var posteComboBox: NSComboBox!
  @IBOutlet weak var equipeComboBox: NSComboBox!

  // Init class data
  var salaries = Salarie.all    // Get Data from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldSalarie = ""   // For update salarie field if necessary

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
extension SalariesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return salaries.count
  }
}

// MARK: - tableView delegate
extension SalariesViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "salarie": textView?.string = salaries[row].salarie ?? ""
      case "nom": textView?.string = salaries[row].nom ?? ""
      case "prenom": textView?.string = salaries[row].prenom ?? ""
      case "service": textView?.string = salaries[row].service ?? ""
      case "fonction": textView?.string = salaries[row].fonction ?? ""
      case "poste": textView?.string = salaries[row].poste ?? ""
      case "equipe": textView?.string = salaries[row].equipe ?? ""
      case "netMensuel": textView?.string = String (salaries[row].netMensuel)
      case "netMensuelMoyen": textView?.string = String (salaries[row].netMensuelMoyen)
      case "netJournalier": textView?.string = String (salaries[row].netJournalier)
      case "netHoraire": textView?.string = String (salaries[row].netHoraire)
      case "commentaire": textView?.string = salaries[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
