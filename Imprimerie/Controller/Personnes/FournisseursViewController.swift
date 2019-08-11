//
//  FournisseursViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/7/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class FournisseursViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!

  // textFields
  @IBOutlet weak var fournisseurTextField: NSTextField!
  @IBOutlet weak var facturationTextField: NSTextField!
  @IBOutlet weak var reglementsTextField: NSTextField!
  @IBOutlet weak var soldeTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!

  // Init datas
  func initDataView() {
    fournisseurTextField.stringValue = ""
    facturationTextField.stringValue = ""
    reglementsTextField.stringValue = ""
    soldeTextField.stringValue = ""
    commentaireTextField.stringValue = ""
  }

  // Init class data
  var fournisseurs = Fournisseur.all    // getDate from entity

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

    // Init datas
    initDataView()
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
