//
//  Extensions.swift
//  Imprimerie
//
//  Created by MAC on 8/4/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation

// MARK: - Date extensions
extension Date {

  // Year to string
  func yearToString (format: String = "yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "FR_fr")
    return formatter.string(from: self)
  }

  // Month to string
  func monthToString (format: String = "MMMM") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "FR_fr")
    let stringMonth = formatter.string(from: self)
    return stringMonth.capitalized
  }

  // Date to string
  func dateToString(format: String = "dd-MM-yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "FR_fr")
    return formatter.string(from: self)
  }

  // Time to string in 24 hour format
  func timeToString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.dateFormat = "HH:mm"
    formatter.locale = Locale(identifier: "FR_fr")
    return formatter.string(from: self)
  }
}
