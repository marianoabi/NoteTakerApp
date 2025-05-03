//
//  DateFormatterService.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation

class DateFormatterService: DateFormatterServiceProtocol {
    private let dateFormatter: DateFormatter
    
    init(dateStyle: DateFormatter.Style = .medium,
         timeStyle: DateFormatter.Style = .short) {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = dateStyle
        self.dateFormatter.timeStyle = timeStyle
    }
    
    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
