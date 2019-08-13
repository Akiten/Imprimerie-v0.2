//
//  OutlineViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

// MARK: - Extention class outlineView
class DataTableCellView: NSTableCellView {
  @IBOutlet weak var inlineButton: NSButton!
}

// MARK: - Extension ViewController
extension ViewController {

  // Add or replace subview
  func addSubView(subView: NSView, toView parentView: NSView) {
    let myView = parentView.subviews
    if myView.count > 0 {
      parentView.replaceSubview(myView[0], with: subView)
    } else {
      parentView.addSubview(subView)
    }
  }
}

// MARK: - outlineView DataSource
extension ViewController: NSOutlineViewDataSource {
  // Sections
  func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
    if let section = item as? Section {
      return section.detail.count
    }
    return section.count
  }

  // Details
  func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
    if let section = item as? Section {
      return section.detail[index]
    }
    return section[index]
  }
}

// MARK: - outlineView Delegate
extension ViewController: NSOutlineViewDelegate {
  // Expandable or not
  func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
    if item is Section {
      return true
    }
    return false
  }

  // Show disclosure triangle or not
  func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
    if item is Section {
      return false
    }
    return true
  }

  // Selection item or not
  func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
    if item is Section {
      return false
    }
    return true
  }

  // Populate outlineView
  func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
    var view: NSTableCellView?
    var dataCellView: DataTableCellView?

    if let section = item as? Section {
      view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeaderCell"), owner: self) as? NSTableCellView
      if let textField = view?.textField {
        textField.stringValue = section.name
        textField.sizeToFit()
      }
    } else if let detail = item as? Detail {
      dataCellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as? DataTableCellView
      if let textField = dataCellView?.textField {
        textField.stringValue = detail.name
        textField.sizeToFit()
      }
      dataCellView?.imageView?.image = NSImage (named: detail.icon)
      dataCellView?.inlineButton.title = detail.count
      switch detail.name {
      case "Consommables": dataCellView?.inlineButton.title = String (Consommable.count)
      case "Jours travaillés": dataCellView?.inlineButton.title = String (JourTravaille.count)
      case "Masse salariale": dataCellView?.inlineButton.title = String (MasseSalariale.count)
      case "Parutions": dataCellView?.inlineButton.title = String (Parution.count)
      case "Clients": dataCellView?.inlineButton.title = String (Client.count)
      case "Fournisseurs": dataCellView?.inlineButton.title = String (Fournisseur.count)
      case "Salariés": dataCellView?.inlineButton.title = String (Salarie.count)
      case "Commandes": dataCellView?.inlineButton.title = String (Commande.count)
      case "Etats de besoins": dataCellView?.inlineButton.title = String (EtatDeBesoin.count)
      case "Facturation": dataCellView?.inlineButton.title = String (Facture.count)
      default: dataCellView?.inlineButton.isHidden = true
      }
      dataCellView?.inlineButton.sizeToFit()
      view = dataCellView
    }
    return view
  }

  // outlineView selection changed
  func outlineViewSelectionDidChange(_ notification: Notification) {
    guard let outlineView = notification.object as? NSOutlineView else { return }
    if let detail = outlineView.item(atRow: outlineView.selectedRow) as? Detail {
      outlineViewSelectedName = detail.name
      updateWindowTitle(outlineViewSelectedName)
      outlineViewSelectedIndex = outlineView.selectedRow
      changeViewItem()
    }
  }

  // Change subView
  func changeViewItem() {
    var vc = NSView()
    switch outlineViewSelectedName {
    case "Consommables": vc = consommablesViewController.view
    case "Jours travaillés": vc = joursTravaillesViewController.view
    case "Masse salariale": vc = massesSalarialesViewController.view
    case "Parutions": vc = parutionsViewController.view
    case "Clients": vc = clientsViewController.view
    case "Fournisseurs": vc = fournisseursViewController.view
    case "Salariés": vc = salariesViewController.view
    case "Commandes": vc = commandesViewController.view
    case "Etats de besoins": vc = etatsDeBesoinsViewController.view
    case "Facturation": vc = facturesViewController.view
    default: vc = NSView()
    }

    addSubView(subView: vc, toView: customView)
    vc.translatesAutoresizingMaskIntoConstraints = false
    var viewBidingsDict = [String: AnyObject]()
    viewBidingsDict["vc"] = vc
    customView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[vc]|", options: [], metrics: nil, views: viewBidingsDict))
    customView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[vc]|", options: [], metrics: nil, views: viewBidingsDict))
  }
}

extension ViewController: updateOutlineView {
  func updateAfterInsertData() {
    outlineView.reloadData(forRowIndexes: [outlineViewSelectedIndex], columnIndexes: [0])
  }
}
