//
//  FacturesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class FacturesViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!
  
  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var saveSegmentedControl: NSSegmentedControl!

  // textFields
  @IBOutlet weak var designationTextField: NSTextField!
  @IBOutlet weak var clientComboBox: NSComboBox!
  @IBOutlet weak var montantTextField: NSTextField!
  @IBOutlet weak var reglementTextField: NSTextField!
  @IBOutlet weak var soldeTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  @IBOutlet weak var dateDatePicker: NSDatePicker!

  // Init class data
  var factures = Facture.all    // Get data from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldDate = ""   // For update date field if necessary
  var oldClient = ""   // For update client field if necessary

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

    // Init date
    dateDatePicker.locale = Locale(identifier: "fr-FR")
    dateDatePicker.dateValue = Date()
  }
}

// MARK: - tableView dataSource
extension FacturesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return factures.count
  }
}

// MARK: - tableView delegate
extension FacturesViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "annee": textView?.string = factures[row].annee
      case "mois": textView?.string = factures[row].mois
      case "date": textView?.string = factures[row].date?.dateToString() ?? ""
      case "client": textView?.string = factures[row].client ?? ""
      case "montant": textView?.string = String(factures[row].montant)
      case "reglements": textView?.string = String(factures[row].reglements)
      case "solde": textView?.string = String(factures[row].solde)
      case "commentaire": textView?.string = factures[row].commentaire ?? ""
      case "designation": textView?.string = factures[row].designation ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
