//
//  LockScreen.swift
//  LockScreen
//
//  Created by Kumar Basant on 22/11/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DataEntry {
       // SimpleEntry(date: Date(), configuration: ConfigurationIntent())
        DataEntry(date: Date(), subjectDetail: DataEntry.mockTravelEntry().subjectDetail)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DataEntry) -> ()) {
       // let entry = SimpleEntry(date: Date(), configuration: configuration)
        let entry = DataEntry(date: Date(), subjectDetail: DataEntry.mockTravelEntry().subjectDetail)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        

        let currentDate = Date()
        let entry = DataEntry(date: Date(), subjectDetail: DataEntry.mockTravelEntry().subjectDetail)
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)

        
    }
}

//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}
struct LockViewSmall:View{
    var body: some View {
        VStack{
            Image(systemName: "lock")
                .resizable()
                .frame(width: 30,height: 40)
            Text(Date().toString())
        }
    }
}
struct LockViewMedium:View{
    var detail:SubjectTime
    var body: some View {
        VStack{
            Image(systemName: "lock")
                .resizable()
                .frame(width: 30,height: 40)
            Text(Date().toString())
            Text("Next Class")
            HStack{
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 2,height: 26)
                Text(detail.subject)
                Text(detail.time)
            }
            .padding(.horizontal,40)
            
        }
    }
}
struct LockViewLarge:View{
   private var sub:[SubjectTime]
    init(sub: [SubjectTime]) {
        self.sub = sub
    }
    var body: some View {
        VStack{
            Image(systemName: "lock")
                .resizable()
                .frame(width: 30,height: 40)
            Text(Date().toString())
            Text("Upcoming Classes")
            ForEach(sub , id: \.subId ){ subject in
                HStack{
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(width: 2,height: 26)
                    Text(subject.subject)
                    Text(subject.time)
                }
                .padding(.horizontal,40)
            }
            
            
        }
    }
}
struct LockScreenEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        //Text(entry.date, style: .time)
        switch widgetFamily{
        case .systemSmall:
            LockViewSmall()
            //Text(entry.date, style: .time)
        case .systemMedium:
            LockViewMedium(detail: entry.subjectDetail.first!)
            //Text(entry.date, style: .time)
        case .systemLarge:
            LockViewLarge(sub:entry.subjectDetail)
           // Text(entry.date, style: .time)
        case .accessoryRectangular:
            //Text(entry.date, style: .time)
            LockViewSmall()
        case .accessoryCircular:
            Gauge(value: 0.8) {
                //Text(entry.date, style: .time)
                LockViewSmall()
            }.gaugeStyle(.accessoryCircular)
            
        case .accessoryInline:
            //Text(entry.date, style: .time)
            LockViewSmall()
        default:
            Text(entry.date, style: .time)
        }
    }
}

@main
struct LockScreen: Widget {
    let kind: String = "LockScreen"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            LockScreenEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .supportedFamilies(
                    [
                        .systemSmall,
                        .systemMedium,
                        .systemLarge,
                        .systemExtraLarge,
                        .accessoryInline,
                        .accessoryCircular,
                        .accessoryRectangular
                    ]
                )
        .description("This is an example widget.")
    }
}

struct LockScreen_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenEntryView(entry: DataEntry.mockTravelEntry())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            //.previewContext(WidgetPreviewContext(family: .accessoryInline))
            //.previewDisplayName("Inline")
        
        LockScreenEntryView(entry: DataEntry.mockTravelEntry())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            //.previewContext(WidgetPreviewContext(family: .accessoryCircular))
            //.previewDisplayName("Circular")
        
        LockScreenEntryView(entry: DataEntry.mockTravelEntry())
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            //.previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            //.previewDisplayName("Rectangular")
    }
}
extension Date{
    func toString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MM.dd.yyyy"
        return formatter.string(from: self)
    }
    
}
struct DataEntry: TimelineEntry {
    let date: Date
    let subjectDetail:[SubjectTime]

    static func mockTravelEntry() -> DataEntry{
        return DataEntry(date: Date(), subjectDetail:[SubjectTime(subId:0,subject: "Math", time: "09:30"),SubjectTime(subId:1,subject: "Physics", time: "12:30"),SubjectTime(subId:2,subject: "Chemistry", time: "02:30")])
    }

}
struct SubjectTime:Decodable {
    let subId:Int
    let subject:String
    let time:String
}
