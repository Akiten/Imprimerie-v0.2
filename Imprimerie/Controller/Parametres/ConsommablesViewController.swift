//
//  ConsommablesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/4/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class ConsommablesViewController: NSViewController {

  // MARK: - Init Delegates
  weak var delegate: updateOutlineView?

  // MARK: - Init Views
  @IBOutlet weak var tableView: NSTableView!

  // MARK: - Init Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var saveSegmentedControl: NSSegmentedControl!

  // MARK: - Init textFields
  @IBOutlet weak var articleTextField: NSTextField!   // Unique
  @IBOutlet weak var uniteTextField: NSTextField!
  @IBOutlet weak var conditionnementTextField: NSTextField!
  @IBOutlet weak var pxAchatTextField: NSTextField!
  @IBOutlet weak var pxRevientTextField: NSTextField!
  @IBOutlet weak var pxVenteTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!
  @IBOutlet weak var designationTextField: NSTextField!

  // MARK: - Init vars
  var consommables = Consommable.all    // Get data from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldArticle = ""   // For update article field if necessary
  var selectedRow = 0   // Selected row for update fields

  // MARK: - View Controller functions
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewWillAppear() {
    super.viewWillAppear()

    // tableView delegates
    tableView.dataSource = self
    tableView.delegate = self

    // Load datas in tableView
    tableView.reloadData()
  }

  // Add or remove data
  @IBAction func addRemoveAction(_ sender: Any) {
    let segmentedControl = sender as! NSSegmentedControl
    let index = segmentedControl.selectedSegment

    // Insert new row and select it
    if index == 0 {
      let insertionIndex = consommables.count
      tableView.insertRows(at: IndexSet (integer: insertionIndex), withAnimation: .effectFade)
      tableView.selectRowIndexes(IndexSet (integer: insertionIndex), byExtendingSelection: false)
      dataInsert = true    // For insert
    }
  }

  // Update datas
  @IBAction func saveAction(_ sender: Any) {
    var messageAlert = ""
    // Save data in Core Data entity
    let article = articleTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let unite = uniteTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let conditionnement = conditionnementTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let commentaire = commentaireTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let pxAchat = componentsJoined (pxAchatTextField.stringValue)
    let pxRevient = componentsJoined (pxRevientTextField.stringValue)
    let pxVente = componentsJoined (pxVenteTextField.stringValue)
    let designation = designationTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)

    pxAchatTextField.stringValue = pxAchat
    pxRevientTextField.stringValue = pxRevient
    pxVenteTextField.stringValue = pxVente

    // Verify nil fields
    if article.isEmpty { messageAlert = "Le champ \"Article\" est obligatoire !" }
    if designation.isEmpty {
      if messageAlert != "" { messageAlert += "\n"}
      messageAlert += "Le champ \"Désignation\" est obligatoire !"
    }

    if messageAlert != "" {
      alertDialogBoxOk (messageAlert)
      return
    }

    // Save in entity
    if dataInsert {
      let consommable = Consommable(context: AppDelegate.viewContext)
      consommable.article = article
      consommable.unite = unite
      consommable.conditionnement = conditionnement
      consommable.pxAchat = Double(pxAchat) ?? 0.0
      consommable.pxRevient = Double(pxRevient) ?? 0.0
      consommable.pxVente = Double(pxVente) ?? 0.0
      consommable.commentaire = commentaire
      consommable.designation = designation
//      dataInsert = false
    } else {
      let request: NSFetchRequest<Consommable> = Consommable.fetchRequest()
      request.predicate = NSPredicate(format: "article = %@", oldArticle)
      let consommable = try? AppDelegate.viewContext.fetch(request)
      if consommable?.count != 0 {
        consommable?[0].article = article
        consommable?[0].unite = unite
        consommable?[0].conditionnement = conditionnement
        consommable?[0].pxAchat = Double(pxAchat) ?? 0.0
        consommable?[0].pxRevient = Double(pxRevient) ?? 0.0
        consommable?[0].pxVente = Double(pxVente) ?? 0.0
        consommable?[0].commentaire = commentaire
        consommable?[0].designation = designation
      }
    }

    // Save & reload Data
    try? AppDelegate.viewContext.save()
    consommables = Consommable.all    // Reload all datas because of sort
    tableView.reloadData()

    // Sending new count after insert and delegate to outlineView to refresh inline Button
    if dataInsert {
      delegate?.updateAfterInsertData()
      dataInsert = false
    }
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

  // Update row & column
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    if row >= consommables.count || row < 0 { return nil }
    let cellIdentifier = (tableColumn?.identifier)?.rawValue ?? ""
    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
      switch cellIdentifier {
      case "article": cell.textField?.stringValue = consommables[row].article ?? ""
      case "unite": cell.textField?.stringValue = consommables[row].unite ?? ""
      case "conditionnement": cell.textField?.stringValue = consommables[row].conditionnement ?? ""
      case "pxAchat": cell.textField?.stringValue = consommables[row].pxAchat.toStringWithoutDigit()
      case "pxRevient": cell.textField?.stringValue = consommables[row].pxRevient.toStringWithoutDigit()
      case "pxVente": cell.textField?.stringValue = consommables[row].pxVente.toStringWithoutDigit()
      case "commentaire": cell.textField?.stringValue = consommables[row].commentaire ?? ""
      case "designation": cell.textField?.stringValue = consommables[row].designation ?? ""
      default: cell.textField?.stringValue = ""
      }
      return cell
      }
    return nil
  }

  // tableView selection changed
  func tableViewSelectionDidChange(_ notification: Notification) {
    selectedRow = tableView.selectedRow
    if selectedRow < consommables.count && selectedRow >= 0 {
      oldArticle = consommables[selectedRow].article ?? ""
      articleTextField.stringValue = consommables[selectedRow].article ?? ""
      uniteTextField.stringValue = consommables[selectedRow].unite ?? ""
      conditionnementTextField.stringValue = consommables[selectedRow].conditionnement ?? ""
      pxAchatTextField.stringValue = consommables[selectedRow].pxAchat.toStringWithoutDigit()
      pxRevientTextField.stringValue = consommables[selectedRow].pxRevient.toStringWithoutDigit()
      pxVenteTextField.stringValue = consommables[selectedRow].pxVente.toStringWithoutDigit()
      commentaireTextField.stringValue = consommables[selectedRow].commentaire ?? ""
      designationTextField.stringValue = consommables[selectedRow].designation ?? ""
    } else {
      articleTextField.stringValue = ""
      uniteTextField.stringValue = ""
      conditionnementTextField.stringValue = ""
      pxAchatTextField.stringValue = ""
      pxRevientTextField.stringValue = ""
      pxVenteTextField.stringValue = ""
      commentaireTextField.stringValue = ""
      designationTextField.stringValue = ""
    }
  }

}
