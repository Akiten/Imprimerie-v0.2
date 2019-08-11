//
//  ParutionsViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/6/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class ParutionsViewController: NSViewController {

  // MARK: - Outlets
  // Views
  @IBOutlet weak var tableView: NSTableView!

  // Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  
  // textFields
  @IBOutlet weak var parutionTextField: NSTextField!    // Unique
  @IBOutlet weak var joursParutionTextField: NSTextField!
  @IBOutlet weak var pxVente4pTextField: NSTextField!
  @IBOutlet weak var pxVente8pTextField: NSTextField!
  @IBOutlet weak var pxVente16pTextField: NSTextField!
  @IBOutlet weak var pxVente24pTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  @IBOutlet weak var clientComboBox: NSComboBox!    // Select customer from customer entity

  // Init datas
  func initDataView() {
    parutionTextField.stringValue = ""
    joursParutionTextField.stringValue = ""
    pxVente4pTextField.stringValue = ""
    pxVente8pTextField.stringValue = ""
    pxVente16pTextField.stringValue = ""
    pxVente24pTextField.stringValue = ""
    commentaireTextField.stringValue = ""
    clientComboBox.stringValue = ""
  }

  // Init class data
  var parutions = Parution.all    // getDate from entity

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

    // Init datas
    initDataView()
  }

}

// MARK: - tableView dataSource
extension ParutionsViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return parutions.count
  }
}

// MARK: - tableView delegate
extension ParutionsViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    var textView = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as? NSTextView

    if textView == nil {
      textView = NSTextView()
      textView?.identifier = tableColumn?.identifier
    }

    if let identifier = (tableColumn?.identifier)?.rawValue {
      switch identifier {
      case "parution": textView?.string = parutions[row].parution ?? ""
      case "client": textView?.string = parutions[row].client ?? ""
      case "joursParutions": textView?.string = parutions[row].joursParution ?? ""
      case "pxVente4p": textView?.string = String (parutions[row].pxVente4p)
      case "pxVente8p": textView?.string = String (parutions[row].pxVente8p)
      case "pxVente16p": textView?.string = String (parutions[row].pxVente16p)
      case "pxVente24p": textView?.string = String (parutions[row].pxVente24p)
      case "commentaire": textView?.string = parutions[row].commentaire ?? ""
      default: textView?.string = ""
      }
    }
    return textView
  }
}

