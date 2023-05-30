//
//  Date+FormattedDateString.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 30.05.2023.
//

import Foundation

extension Date {
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

