//
//  ClientsViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/4/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class ClientsViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!

  // textFields
  @IBOutlet weak var clientTextField: NSTextField!    // Unique
  @IBOutlet weak var facturationTextField: NSTextField!
  @IBOutlet weak var reglementsTextField: NSTextField!
  @IBOutlet weak var soldeTextField: NSTextField!   // Calculated field
  @IBOutlet weak var commentaireTextField: NSTextField!
  
  // Init
  var clients = Client.all    // getDate from entity

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
extension ClientsViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return clients.count
  }
}

// MARK: - tableView delegate
extension ClientsViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "client": textView?.string = clients[row].client ?? ""
      case "facturation": textView?.string = String (clients[row].facturation)
      case "reglements": textView?.string = String (clients[row].reglements)
      case "solde": textView?.string = String (clients[row].solde)
      case "commentaire": textView?.string = clients[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
