//
//  HorizontalScrollView.swift
//  ScrollableCalendarKit
//
//  Created by Alpay Calalli on 21.11.24.
//

import SwiftUI

struct HorizontalScrollView: View {
    @Binding var days: [Date.WeekDay]
    @Binding var selectedDay: Date.WeekDay
    
    @State private var scrollId: UUID?
    
    @Binding var isManualScrollNeeded: Bool
    
    @State private var firstAppear = true
    
    @State private var isInteracting = false
    
    @State private var yearChanged = false
    
    private var leadingPullState: PullState {
        guard let index = days.firstIndex(where:  { $0.id == scrollId }) else { return .idle}
        
        switch index {
        case 0...1: return .action
        case 2: return .triggered
        default: return .idle
        }
    }
    
    private var trailingPullState: PullState {
        guard let index = days.firstIndex(where:  { $0.id == scrollId }) else { return .idle}
        
        switch days.count - index - 1 {
        case 0...1: return .action
        case 2: return .triggered
        default: return .idle
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(days) { day in
                        DayView(day: day, currentDate: selectedDay.date)
//                            .id(day.id)
                            .containerRelativeFrame(.horizontal, count: 7, spacing: 10)
                            .onTapGesture {
                                handleDayTap(day, proxy: proxy)
                            }
                    }
                }
                .scrollTargetLayout()
                .overlay(alignment: .leading) {
                    PullIndicator(title: String(selectedDay.date.year - 1), alignment: .leading, state: leadingPullState)
                        .onChange(of: leadingPullState) { old, new in
                            if old == .action, new == .triggered, !isInteracting {
                                withAnimation {
                                    days = selectedDay.date.addingDayInterval(-365).fetchYear()
                                    scrollId = days[days.count - 4].id
                                    yearChanged = true
                                }
                            }
                        }
                }
                .overlay(alignment: .trailing) {
                    PullIndicator(title: String(selectedDay.date.year + 1), alignment: .trailing, state: trailingPullState)
                        .onChange(of: trailingPullState) { old, new in
                            if old == .action, new == .triggered, !isInteracting {
                                withAnimation {
                                    days = selectedDay.date.addingDayInterval(365).fetchYear()
                                    scrollId = days[3].id
                                    yearChanged = true
                                }
                            }
                        }
                }
            }
            .contentMargins(10, for: .scrollContent)
            .sensoryFeedback(.selection, trigger: leadingPullState)
            .sensoryFeedback(.selection, trigger: trailingPullState)
            .sensoryFeedback(.success, trigger: yearChanged)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollPosition(id: $scrollId, anchor: .center)
            .onScrollPhaseChange({ oldPhase, newPhase in
                isInteracting = newPhase == .interacting
            })
            .onChange(of: selectedDay) { oldValue, newValue in
                guard isManualScrollNeeded else { return }
                proxy.scrollTo(selectedDay.id, anchor: .center)
            }
            .onChange(of: scrollId) { oldValue, newValue in
                if let day = days.first(where: { $0.id == newValue}) {
                    isManualScrollNeeded = false
                    selectedDay = day
                }
            }
            .onDisappear {
                scrollId = selectedDay.id
            }
            .task {
                if days.isEmpty {
                    days.append(contentsOf: Date().fetchYear())
                    
                    if let today = days.day(from: .now) {
                        
                        proxy.scrollTo(today.id, anchor: .center)
                        scrollId = days.day(from: .now)?.id
                    }
                }
            }
            .frame(height: 90)
        }
    }
    
    private func handleDayTap(_ day: Date.WeekDay, proxy: ScrollViewProxy) {
        isManualScrollNeeded = false
        selectedDay = day
        
        withAnimation {
            proxy.scrollTo(selectedDay.id, anchor: .center)
        }
    }
}
