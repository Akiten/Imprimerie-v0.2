//
//  WindowController.swift
//  Imprimerie
//
//  Created by MAC on 8/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Cocoa

// MARK: - WindowController
class WindowController: NSWindowController {

  // MARK: - Outlets
  @IBOutlet weak var monthPopUpButton: NSPopUpButton!   // Month popUp
  @IBOutlet weak var yearPopUpButton: NSPopUpButton!    // Yer popUp
  @IBOutlet weak var windowTitleButton: NSButton!   // Window title
  @IBOutlet weak var searchField: NSSearchField!    // Search field
  
  // MARK: - Class functions
  override func windowDidLoad() {
    super.windowDidLoad()

    // Init
    monthPopUpButton.selectItem(at: MainWindow.currentMonth)    // Select current month
    yearPopUpButton.selectItem(at: 1)    // Select current year
    windowTitleButton.title = MainWindow.windowTitle   // Update window title
  }

}
