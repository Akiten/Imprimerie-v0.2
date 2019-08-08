//
//  MassesSalarialesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/6/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class MassesSalarialesViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!
  
  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  
  // textFields
  @IBOutlet weak var anneeTextField: NSTextField!   // Unique
  @IBOutlet weak var mensuelleTextField: NSTextField!
  @IBOutlet weak var annuelleTextField: NSTextField!    // Calculated - mensuelle * 12
  @IBOutlet weak var mensuelleMoyenneTextField: NSTextField!
  @IBOutlet weak var journaliereTextField: NSTextField!
  @IBOutlet weak var horaireTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!

  // Init
  var massesSalariales = MasseSalariale.all    // getDate from entity

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
extension MassesSalarialesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return massesSalariales.count
  }
}

// MARK: - tableView delegate
extension MassesSalarialesViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "annee": textView?.string = massesSalariales[row].annee ?? ""
      case "annuelle": textView?.string = String (massesSalariales[row].annuelle)
      case "mensuelle": textView?.string = String (massesSalariales[row].mensuelle)
      case "mensuelleMoyenne": textView?.string = String (massesSalariales[row].mensuelleMoyenne)
      case "journaliere": textView?.string = String (massesSalariales[row].journaliere)
      case "horaire": textView?.string = String (massesSalariales[row].horaire)
      case "commentaire": textView?.string = massesSalariales[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}
