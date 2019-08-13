//
//  FournisseursViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/7/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class FournisseursViewController: NSViewController {

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
  @IBOutlet weak var fournisseurTextField: NSTextField!
  @IBOutlet weak var facturationTextField: NSTextField!
  @IBOutlet weak var reglementsTextField: NSTextField!
  @IBOutlet weak var soldeTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!

  // Init class data
  var fournisseurs = Fournisseur.all    // Get Data from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldfournisseur = ""   // For update fournisseur field if necessary

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
extension FournisseursViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return fournisseurs.count
  }
}

// MARK: - tableView delegate
extension FournisseursViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "fournisseur": textView?.string = fournisseurs[row].fournisseur ?? ""
      case "facturation": textView?.string = String (fournisseurs[row].facturation)
      case "reglements": textView?.string = String (fournisseurs[row].reglements)
      case "solde": textView?.string = String (fournisseurs[row].solde)
      case "commentaire": textView?.string = fournisseurs[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
