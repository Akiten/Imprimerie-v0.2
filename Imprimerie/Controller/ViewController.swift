//
//  ViewController.swift
//  Imprimerie
//
//  Created by MAC on 8/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  // MARK: - Outlets
  @IBOutlet weak var outlineView: NSOutlineView!    // OutlineView
  @IBOutlet weak var customView: NSView!

  // MARK: - Init
  var section = [Section]()   // Sections outlineView
  var outlineViewSelectedName = ""    // Item selected name
  var outlineViewSelectedIndex = 0    // Selected row

  // Views declaration for outlineView change row to update data
  var consommablesViewController = ConsommablesViewController()
  var joursTravaillesViewController = JoursTravaillesViewController()
  var massesSalarialesViewController = MassesSalarialesViewController()
  var parutionsViewController = ParutionsViewController()
  var clientsViewController = ClientsViewController()
  var fournisseursViewController = FournisseursViewController()
  var salariesViewController = SalariesViewController()
  var commandesViewController = CommandesViewController()
  var etatsDeBesoinsViewController = EtatDeBesoinViewController()
  var facturesViewController = FacturesViewController()

  // MARK: - Class functions
  override func viewDidLoad() {
    super.viewDidLoad()

    // outlineView
    section = initOutlineView()
    outlineView.dataSource = self
    outlineView.delegate = self
    outlineView.reloadData()
    outlineView.expandItem(nil, expandChildren: true)
    outlineView.selectRowIndexes(NSIndexSet(index: 1) as IndexSet, byExtendingSelection: false)
    outlineViewSelectedName = section[0].detail[0].name

    // Delegates
    consommablesViewController.delegate = self
  }

  // Window title
  override func viewDidAppear() {
    super.viewDidAppear()
    updateWindowTitle(outlineViewSelectedName)
  }

  // Update window title
  func updateWindowTitle (_ title: String) {
    if let parentWindowController = self.view.window?.windowController as? WindowController {
      parentWindowController.windowTitleButton.title = "\(MainWindow.windowTitle) - \(title)"
    }

  }
}
