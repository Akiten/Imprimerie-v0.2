//
//  ConsommablesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/4/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class ConsommablesViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  
  // textFields
  @IBOutlet weak var articleTextField: NSTextField!   // Unique
  @IBOutlet weak var uniteTextField: NSTextField!
  @IBOutlet weak var conditionnementTextField: NSTextField!
  @IBOutlet weak var pxAchatTextField: NSTextField!
  @IBOutlet weak var pxRevientTextField: NSTextField!
  @IBOutlet weak var pxVenteTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  
  // Init
  var consommables = Consommable.all    // getDate from entity

  // MARK: - View Controller functions
  override func viewDidLoad() {
    super.viewDidLoad()
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
extension ConsommablesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return consommables.count
  }
}

// MARK: - tableView delegate
extension ConsommablesViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "article": textView?.string = consommables[row].article ?? ""
      case "unite": textView?.string = consommables[row].unite ?? ""
      case "conditionnement": textView?.string = consommables[row].conditionnement ?? ""
      case "pxAchat": textView?.string = String (consommables[row].pxAchat)
      case "pxRevient": textView?.string = String (consommables[row].pxRevient)
      case "pxVente": textView?.string = String (consommables[row].pxVente)
      case "commentaire": textView?.string = consommables[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
