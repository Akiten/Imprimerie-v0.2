//
//  Extensions.swift
//  Imprimerie
//
//  Created by MAC on 8/4/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation
import Cocoa

// MARK: - Message boxes
// Alert OK
func alertDialogBoxOk (_ textMessage: String) {
  let alert = NSAlert()
  alert.messageText = textMessage
  alert.alertStyle = .warning
  alert.addButton(withTitle: "OK")
  alert.runModal()
}
func informationalDialogBoxOk (_ textMessage: String) {
  let alert = NSAlert()
  alert.messageText = textMessage
  alert.alertStyle = .informational
  alert.addButton(withTitle: "OK")
  alert.runModal()
}

// MARK: - String extensions
extension String {
  var isDouble: Bool { return Double (self) != nil }
}

// MARK: - Double extensions
extension Double {
  // To String
  func toStringWithoutDigit () -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "fr-FR")
    formatter.format = "# ###"
    formatter.numberStyle = .decimal
    formatter.zeroSymbol = ""
    return formatter.string(from: NSNumber(value: self)) ?? ""
  }
}

// MARK: - Date extensions
extension Date {

  // Year to string
  func yearToString () -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "fr-FR")
    formatter.dateStyle = .short
    formatter.dateFormat = "yyyy"
    return formatter.string(from: self)
  }

  // Month to string
  func monthToString () -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "fr-FR")
    formatter.dateStyle = .short
    formatter.dateFormat = "MMMM"
    let stringMonth = formatter.string(from: self)
    return stringMonth.capitalized
  }

  // Date to string
  func dateToString() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "fr-FR")
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: self)
  }

  // Time to string in 24 hour format
  func timeToString() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "fr-FR")
    formatter.dateStyle = .none
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: self)
  }
}
