//
//  PullState.swift
//  ScrollableCalendarKit
//
//  Created by Alpay Calalli on 21.11.24.
//

import SwiftUI

enum PullState: Hashable {
    case idle
    case triggered
    case action
}

struct PullIndicator: View {
    let title: String
    let symbolName: String
    let symbolAlignment: Alignment
    let state: PullState
    
    init(title: String, symbolName: String, symbolAlignment: Alignment, state: PullState) {
        self.title = title
        self.symbolName = symbolName
        self.symbolAlignment = symbolAlignment
        self.state = state
    }
    
    init(title: String, alignment: Alignment, state: PullState) {
        self.title = title
        self.symbolName = alignment == .leading ? "chevron.left" : "chevron.right"
        self.symbolAlignment = alignment
        self.state = state
    }
    
    var body: some View {
        HStack {
            if symbolAlignment == .leading {
                Image(systemName: symbolName)
                Text(title)
            } else if symbolAlignment == .trailing {
                Text(title)
                Image(systemName: symbolName)
            }
        }
        .padding(10)
        .background(state == .action ? AnyShapeStyle(Color.green) : AnyShapeStyle(Color.gray.opacity(0.3)))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .opacity(1)
        .offset(x: symbolAlignment == .leading ? -90 : 90)
    }
}
