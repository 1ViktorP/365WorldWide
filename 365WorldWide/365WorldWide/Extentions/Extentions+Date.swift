//
//  Extentions+Date.swift
//  365WorldWide
//
//  Created by MacBook on 26.07.2023.
//

import Foundation

extension Date {
    static var getNextWeek: String {
        var dayComponent = DateComponents()
        dayComponent.day = 7
        let calendar = Calendar.current
        let nextDate = calendar.date(byAdding: dayComponent, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: nextDate ?? Date())
    }
    
    var getRangeSevenDays: [Date] {
        let calendar = Calendar.current
        let previousDate = calendar.date(byAdding: .day, value: -3, to: Date())
        let nextDate = calendar.date(byAdding: .day, value: 3, to: Date())
        var dates = Date.dates(from: Date(), to: nextDate ?? Date())
        dates += Date.dates(from: previousDate ?? Date(), to: Date())
        return dates
    }
    
    static var getNextThirtyDays: Date {
        var dayComponent = DateComponents()
        dayComponent.day = 31
        let calendar = Calendar.current
        let nextDate = calendar.date(byAdding: dayComponent, to: Date())
        return nextDate ?? Date()
    }
    
    static var getPreviousThirtyDays: Date {
        //        var dayComponent = DateComponents()
        //        dayComponent.day = 30
        let calendar = Calendar.current
        let previousDate = calendar.date(byAdding: .day, value: -31, to: Date())
        return previousDate ?? Date()
    }
    
    static var getDayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    static var getHourBefore: Date {
        return Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
    }
    
    
    static var getYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: Date())
    }
    
    static var getToday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    static func formatForURL(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateForCell(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: Date())
    }
    
    static func formatDateForDetailVC(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "d, MMMM, HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatHours(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }
    
    
    static func formatFromServer(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateForDetailView(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateForFavorites(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func formatPlayerBirth(str: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: str) {
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            var str = dateFormatter.string(from: date)
            return str
        }
        return ""
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    static func dayFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E"
        let dateDay = dateFormatter.string(from: date)
        return dateDay
    }
    
    static func dayNumberFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "d"
        let dateDay = dateFormatter.string(from: date)
        return dateDay
    }
    
    static func fullDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE, MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
}
