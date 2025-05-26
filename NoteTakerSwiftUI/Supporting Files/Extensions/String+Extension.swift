//
//  String+Extension.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/26/25.
//

import Foundation

extension String {
    func formatted(with arguments: CVarArg...) -> String {
        return String(format: self, arguments)
    }
}
