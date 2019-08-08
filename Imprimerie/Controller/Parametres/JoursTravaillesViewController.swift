//
//  JoursTravaillesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/5/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class JoursTravaillesViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!

  // textFields
  @IBOutlet weak var anneeTextField: NSTextField!   // Unique
  @IBOutlet weak var nbJoursTextField: NSTextField!
  @IBOutlet weak var nbJoursOuvresTextField: NSTextField!
  @IBOutlet weak var nbJoursFeriesTextField: NSTextField!
  @IBOutlet weak var nbJoursTravaiilesTextField: NSTextField!   // Calculated field
  @IBOutlet weak var commentaireTextField: NSTextField!

  // Init
  var joursTravailles = JourTravaille.all    // getDate from entity

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
extension JoursTravaillesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return joursTravailles.count
  }
}

// MARK: - tableView delegate
extension JoursTravaillesViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "annee": textView?.string = joursTravailles[row].annee ?? ""
      case "nbJours": textView?.string = String (joursTravailles[row].nbJours)
      case "nbJoursOuvres": textView?.string = String (joursTravailles[row].nbJoursOuvres)
      case "nbJoursFeries": textView?.string = String (joursTravailles[row].nbJoursFeries)
      case "nbJoursTravailles": textView?.string = String (joursTravailles[row].nbJoursTravailles)
      case "commentaire": textView?.string = joursTravailles[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
