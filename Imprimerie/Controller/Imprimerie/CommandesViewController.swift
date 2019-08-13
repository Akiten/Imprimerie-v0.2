//
//  CommandesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/8/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class CommandesViewController: NSViewController {

  // MARK: - Init Delegates
  weak var delegate: updateOutlineView?

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var saveSegmentedControl: NSSegmentedControl!
  
  // textFields
  @IBOutlet weak var fournisseurComboBox: NSComboBox!
  @IBOutlet weak var montantTextField: NSTextField!
  @IBOutlet weak var reglementsTextField: NSTextField!
  @IBOutlet weak var soldeTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  @IBOutlet weak var designationTextField: NSTextField!
  @IBOutlet weak var dateDatePicker: NSDatePicker!

  // Init class data
  var commandes = Commande.all    // getDate from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldDate = ""   // For update date field if necessary
  var oldFournisseur = ""   // For update fournisseur field if necessary

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
extension CommandesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return commandes.count
  }
}

// MARK: - tableView delegate
extension CommandesViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "annee": textView?.string = commandes[row].annee
      case "mois": textView?.string = commandes[row].mois
      case "date": textView?.string = commandes[row].date?.dateToString() ?? ""
      case "fournisseur": textView?.string = commandes[row].fournisseur ?? ""
      case "montant": textView?.string = String(commandes[row].montant)
      case "reglements": textView?.string = String(commandes[row].reglements)
      case "solde": textView?.string = String(commandes[row].solde)
      case "commentaire": textView?.string = commandes[row].commentaire ?? ""
      case "designation": textView?.string = commandes[row].designation ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
