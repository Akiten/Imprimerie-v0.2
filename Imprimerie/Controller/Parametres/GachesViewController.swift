//
//  GachesViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/13/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class GachesViewController: NSViewController {

  // MARK: - Init Delegates
  weak var delegate: updateOutlineView?

  // MARK: - Init Views
  @IBOutlet weak var tableView: NSTableView!

  // MARK: - Init Controls
  @IBOutlet weak var addRemoveSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var importExportSegmentedControl: NSSegmentedControl!
  @IBOutlet weak var saveSegmentedControl: NSSegmentedControl!

  // MARK: - Init textFields
  @IBOutlet weak var produitTextField: NSTextField!
  @IBOutlet weak var uniteTextField: NSTextField!
  @IBOutlet weak var pxVenteTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!

  // MARK: - Init vars
  var gaches = Gache.all    // Get data from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldProduit = ""   // For update produit field if necessary
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
      let insertionIndex = gaches.count
      tableView.insertRows(at: IndexSet (integer: insertionIndex), withAnimation: .effectFade)
      tableView.selectRowIndexes(IndexSet (integer: insertionIndex), byExtendingSelection: false)
      dataInsert = true    // For insert
    }
  }

  // Update datas
  @IBAction func saveAction(_ sender: Any) {
    var messageAlert = ""
    // Save data in Core Data entity
    let produit = produitTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let unite = uniteTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let pxVente = componentsJoined (pxVenteTextField.stringValue)
    let commentaire = commentaireTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)

    pxVenteTextField.stringValue = pxVente

    // Verify nil fields
    if produit.isEmpty { messageAlert = "Le champ \"Produit\" est obligatoire !" }

    if messageAlert != "" {
      alertDialogBoxOk (messageAlert)
      return
    }

    // Save in entity
    if dataInsert {
      let gache = Gache(context: AppDelegate.viewContext)
      gache.produit = produit
      gache.unite = unite
      gache.pxVente = Double(pxVente) ?? 0.0
      gache.commentaire = commentaire
    } else {
      let request: NSFetchRequest<Gache> = Gache.fetchRequest()
      request.predicate = NSPredicate(format: "produit = %@", oldProduit)
      let gache = try? AppDelegate.viewContext.fetch(request)
      if gache?.count != 0 {
        gache?[0].produit = produit
        gache?[0].unite = unite
        gache?[0].pxVente = Double(pxVente) ?? 0.0
        gache?[0].commentaire = commentaire
      }
    }

    // Save & reload Data
    try? AppDelegate.viewContext.save()
    gaches = Gache.all    // Reload all datas because of sort
    tableView.reloadData()

    // Sending new count after insert and delegate to outlineView to refresh inline Button
    if dataInsert {
      delegate?.updateAfterInsertData()
      dataInsert = false
    }
  }

}

// MARK: - tableView dataSource
extension GachesViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return gaches.count
  }
}

// MARK: - tableView delegate
extension GachesViewController: NSTableViewDelegate {

  // Update row & column
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    if row >= gaches.count || row < 0 { return nil }
    let cellIdentifier = (tableColumn?.identifier)?.rawValue ?? ""
    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
      switch cellIdentifier {
      case "produit": cell.textField?.stringValue = gaches[row].produit ?? ""
      case "unite": cell.textField?.stringValue = gaches[row].unite ?? ""
      case "pxVente": cell.textField?.stringValue = gaches[row].pxVente.toStringWithoutDigit()
      case "commentaire": cell.textField?.stringValue = gaches[row].commentaire ?? ""
      default: cell.textField?.stringValue = ""
      }
      return cell
    }
    return nil
  }

  // tableView selection changed
  func tableViewSelectionDidChange(_ notification: Notification) {
    selectedRow = tableView.selectedRow
    if selectedRow < gaches.count && selectedRow >= 0 {
      oldProduit = gaches[selectedRow].produit ?? ""
      produitTextField.stringValue = gaches[selectedRow].produit ?? ""
      uniteTextField.stringValue = gaches[selectedRow].unite ?? ""
      pxVenteTextField.stringValue = gaches[selectedRow].pxVente.toStringWithoutDigit()
      commentaireTextField.stringValue = gaches[selectedRow].commentaire ?? ""
    } else {
      produitTextField.stringValue = ""
      uniteTextField.stringValue = ""
      pxVenteTextField.stringValue = ""
      commentaireTextField.stringValue = ""
    }
  }

}

