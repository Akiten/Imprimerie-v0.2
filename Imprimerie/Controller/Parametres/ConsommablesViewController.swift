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
  @IBOutlet weak var saveSegmentedControl: NSSegmentedControl!
  
  // textFields
  @IBOutlet weak var articleTextField: NSTextField!   // Unique
  @IBOutlet weak var uniteTextField: NSTextField!
  @IBOutlet weak var conditionnementTextField: NSTextField!
  @IBOutlet weak var pxAchatTextField: NSTextField!
  @IBOutlet weak var pxRevientTextField: NSTextField!
  @IBOutlet weak var pxVenteTextField: NSTextField!
  @IBOutlet weak var commentaireTextField: NSTextField!

  // Init class data
  var consommables = Consommable.all    // getDate from entity
  var dataInsert = false    // For Insert or Update data in entity Core Data
  var oldArticle = ""   // For update article field if necessary

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

  // Add or remove data
  @IBAction func addRemoveAction(_ sender: Any) {
    let segmentedControl = sender as! NSSegmentedControl
    let index = segmentedControl.selectedSegment

    // Insert new row
    if index == 0 {
      let insertionIndex = consommables.count
      tableView.insertRows(at: IndexSet (integer: insertionIndex), withAnimation: .effectFade)
      tableView.selectRowIndexes(IndexSet (integer: insertionIndex), byExtendingSelection: false)
      dataInsert = true    // For Insert
    }
  }

  @IBAction func saveAction(_ sender: Any) {

    // Save data in Core Data entity
    let article = articleTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let unite = uniteTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let conditionnement = conditionnementTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    let commentaire = commentaireTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)

    var pxAchat = pxAchatTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    var components = pxAchat.components(separatedBy: CharacterSet.decimalDigits.inverted)
    pxAchat = components.joined()
    if pxAchat.isEmpty { pxAchat = "0.0" }

    var pxRevient = pxRevientTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    components = pxRevient.components(separatedBy: CharacterSet.decimalDigits.inverted)
    pxRevient = components.joined()
    if pxRevient.isEmpty { pxRevient = "0.0" }

    var pxVente = pxVenteTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
    components = pxVente.components(separatedBy: CharacterSet.decimalDigits.inverted)
    pxVente = components.joined()
    if pxVente.isEmpty { pxVente = "0.0" }

    // Verify nil fields
    if article.isEmpty {
      dialogOK ("Le champ \"Article\" est obligatoires !")
      return
    }

    // Verify numeric fields
    if pxAchat.isDouble == false || pxRevient.isDouble == false || pxVente.isDouble == false {
      dialogOK ("Les champs \"Prix d'achat\", \"Prix de revient\" & \"Prix de vente\" ne doivent contenir que des chiffres !")
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
      try? AppDelegate.viewContext.save()
      dataInsert = false
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
        try? AppDelegate.viewContext.save()
      }
    }

    // Reload Data
    consommables = Consommable.all
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
      default: cell.textField?.stringValue = ""
      }
      return cell
      }
    return nil
  }

  // tableView selection changed
  func tableViewSelectionDidChange(_ notification: Notification) {
    let selected = tableView.selectedRow
    if selected < consommables.count && selected >= 0 {
      articleTextField.stringValue = consommables[selected].article ?? ""
      oldArticle = consommables[selected].article ?? ""
      uniteTextField.stringValue = consommables[selected].unite ?? ""
      conditionnementTextField.stringValue = consommables[selected].conditionnement ?? ""
      pxAchatTextField.stringValue = consommables[selected].pxAchat.toStringWithoutDigit()
      pxRevientTextField.stringValue = consommables[selected].pxRevient.toStringWithoutDigit()
      pxVenteTextField.stringValue = consommables[selected].pxVente.toStringWithoutDigit()
      commentaireTextField.stringValue = consommables[selected].commentaire ?? ""
    } else {
      articleTextField.stringValue = ""
      uniteTextField.stringValue = ""
      conditionnementTextField.stringValue = ""
      pxAchatTextField.stringValue = ""
      pxRevientTextField.stringValue = ""
      pxVenteTextField.stringValue = ""
      commentaireTextField.stringValue = ""
    }
  }

}
