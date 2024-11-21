# ScrollableCalendarKit

ScrollableCalendarKit is a scrollable calendar view similar to one used in Apple Health App's Medications section.

![](https://github.com/alpaycli/ScrollableCalendarKit/blob/main/Preview.gif)

## Installation

#### Requirements

- iOS 18.0+

#### Via Swift Package Manager

- Go to File > Add Package Dependencies...
- Paste https://github.com/alpaycli/ScrollableCalendarKit.git
- Select the version and add the package to your project.

## Usage

### Basic Usage
```Swift
import ScrollableCalendarKit
import SwiftUI

struct ContentView: View {
    @State var currentDate: Date.WeekDay = .init(date: .now)
    
    var body: some View {
        ScrollableCalendarView(currentDate: $currentDate)
    }
}
```

## License

ScrollableCalendarKit is available under the MIT license. See the LICENSE file for more info.

## Contributions

Contributions are welcome! If you have any suggestions or improvements, please create an issue or submit a pull request.
