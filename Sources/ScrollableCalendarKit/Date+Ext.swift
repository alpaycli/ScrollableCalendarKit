//
//  File.swift
//  ScrollableCalendarKit
//
//  Created by Alpay Calalli on 21.11.24.
//

import SwiftUI

extension Date {
    public struct WeekDay: Identifiable, Hashable {
        public var id = UUID()
        public var date: Date
        
        public init(id: UUID = UUID(), date: Date) {
            self.id = id
            self.date = date
        }
    }
}

extension Array where Element == Date.WeekDay {
    func day(from date: Date) -> Date.WeekDay? {
        self.first(where: { $0.date.isSameDayWith(date) })
    }
}

extension Date {
    func fetchYear() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        
        var year: [WeekDay] = []
        let yearForDate = calendar.dateInterval(of: .year, for: startOfDate)
        guard let startOfYear = yearForDate?.start else { return [] }
        
        var currentDate = startOfYear
        while currentDate < yearForDate!.end {
            year.append(.init(date: currentDate))
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return year
    }
}

extension Date {
    var isCurrentYear: Bool {
        Calendar.current.dateComponents([.year], from: self).year ==
        Calendar.current.dateComponents([.year], from: Date()).year
    }
    
    /**
         Compares if the date is on the same day as another date.

         This function checks if the date it is called on falls on the same calendar day as the provided date.

         - Parameter date: The date to compare with.

         - Returns: A Boolean value indicating whether the two dates are on the same day.
     */
    func isSameDayWith(_ date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var year: Int {
        let calendar = Calendar.current
        
        return calendar.component(.year, from: self)
    }
}

extension Date {
    
    /// Adds a specified number of days to the date.
    /// - Parameter days: The number of days to add.
    /// - Returns: A new date that is the specified number of days later than the original date.
    func addingDayInterval(_ days: Double) -> Date {
        self.addingHourInterval(days * 24)
    }
    
    /// Adds a specified number of hours to the date.
    /// - Parameter hours: The number of days to add.
    /// - Returns: A new date that is the specified number of hours later than the original date.
    func addingHourInterval(_ hours: Double) -> Date {
        self.addingTimeInterval(hours * 3600)
    }
}

// MARK: - Formatter extensions

extension Date {
    func format(_ format: String = "EEEE, MMMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}
