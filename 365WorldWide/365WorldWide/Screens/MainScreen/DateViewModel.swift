//
//  DataViewModel.swift
//  365WorldWide
//
//  Created by MacBook on 26.07.2023.
//

import Foundation


struct DateCellViewModel {
    let day: String
    let date: String
    let dateForURL: String
}

class DateViewModel {
    
    var dateCell: [DateCellViewModel] = []
    
    func prepareDateCell(date: Date) {
        let dates = date.getRangeSevenDays
        
        dates.forEach { date in
            let formattedDates = Date.dayFormat(date: date)
            dateCell.append(DateCellViewModel(day: Date.dayFormat(date: date),
                                              date:Date.dayNumberFormat(date: date),
                                              dateForURL: Date.formatForURL(date: date)))
        }
    }
}
