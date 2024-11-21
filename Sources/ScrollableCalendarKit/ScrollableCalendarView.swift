//
//  ScrollableCalendarView.swift
//  ScrollableCalendarKit
//
//  Created by Alpay Calalli on 21.11.24.
//

import SwiftUI

public struct ScrollableCalendarView: View {
    @Binding public var currentDate: Date.WeekDay
    @State private var allDays: [Date.WeekDay] = []
    
    @State private var scrollId: Date.WeekDay.ID?
    
    @State private var isManualScrollNeeded = false
    
    var currentDateLabel: String {
        if currentDate.date.isCurrentYear {
            currentDate.date.format("EEEE, d MMMM")
        } else {
            currentDate.date.format("d MMMM, yyyy")
        }
    }
    
    public init(currentDate: Binding<Date.WeekDay>) {
        _currentDate = currentDate
    }
            
    public var body: some View {
        content
    }
}

extension ScrollableCalendarView {
    private var content: some View {
        VStack(alignment: .center) {
            Text(currentDateLabel)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.leading, 10)
                .onTapGesture {
                    isManualScrollNeeded = true
                    if let today = allDays.day(from: .now) {
                        withAnimation {
                            currentDate = today
                        }
                    }
                }
            
            Image(systemName: "chevron.down")
            
            HorizontalScrollView(
                days: $allDays,
                selectedDay: $currentDate,
                isManualScrollNeeded: $isManualScrollNeeded
            )
        }
        .padding(.vertical, 15)
    }
}

#Preview {
    @Previewable @State var currentDate: Date.WeekDay = .init(date: .now)
    @Previewable @State var manualScrollNeeded = false
    VStack {
        ScrollableCalendarView(currentDate: $currentDate)
    }
}
