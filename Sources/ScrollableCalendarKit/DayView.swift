//
//  File.swift
//  ScrollableCalendarKit
//
//  Created by Alpay Calalli on 21.11.24.
//

import SwiftUI

struct DayView: View {
    
    let day: Date.WeekDay
    let currentDate: Date
    
    var body: some View {
        VStack(spacing: 8) {
            Text(day.date.formatted(.dateTime.weekday(.abbreviated)))
                .font(.callout)
                .fontWeight(.medium)
                .textScale(.secondary)
                .foregroundStyle(.secondary)
            
            Text(day.date.formatted(.dateTime.day(.defaultDigits)))
                .font(.callout)
                .fontWeight(.bold)
                .textScale(.secondary)
                .foregroundStyle(day.date.isSameDayWith(currentDate) ? .black : .gray)
                .frame(width: 35, height: 35)
                .background {
                    if day.date.isSameDayWith(currentDate) {
                        Circle()
                            .fill(Color.teal.secondary)
                    }
                    
                    if day.date.isToday {
                        Circle()
                            .fill(.cyan)
                            .frame(width: 5, height: 5)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .offset(y: 12)
                    }
                }
                .background(.white.shadow(.drop(radius: 1)), in: .circle)
        }
    }
}

#Preview {
    DayView(day: .init(date: .now), currentDate: .now)
}
