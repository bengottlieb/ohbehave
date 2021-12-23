//
//  RecordedBehaviorListView.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/23/21.
//

import Suite
import Internal

struct RecordedBehaviorListView: View {
	@ObservedObject var day: DayMO
	
	var body: some View {
		List() {
			ForEach(day.loggedBehaviors) { log in
				HStack() {
					if let behavior = log.behavior(in: day.managedObjectContext) {
						VStack(alignment: .leading) {
							Text(behavior.title)
							if let date = log.date {
								Text(date.localTimeString(date: .none))
							}
						}
						Spacer()
						ValueView(behavior: behavior)
							.padding(5)
					} else {
						Text("Missing Behavior")
					}
				}
				.padding(5)
			}
			.onDelete { indexes in
				day.deleteBehaviors(at: indexes)
				day.save()
			}
		}
		.listStyle(.plain)
	}
}

//struct RecordedBehaviorListView_Previews: PreviewProvider {
//	static var previews: some View {
//		RecordedBehaviorListView()
//	}
//}
