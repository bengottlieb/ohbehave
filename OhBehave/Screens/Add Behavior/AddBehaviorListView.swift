//
//  BehaviorListView.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct AddBehaviorListView: View {
	@ObservedObject var day: DayMO
	@Binding var hideAlreadyAddedBehaviors: Bool
	
	@Environment(\.managedObjectContext) var context
	@FetchRequest(entity: BehaviorMO.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \BehaviorMO.title, ascending: true)]) var behaviors: FetchedResults<BehaviorMO>
	
	var selectBehavior: (BehaviorMO) -> Void
	
	var body: some View {
		ScrollView() {
			VStack() {
				ForEach(behaviors) { behavior in
					if !hideAlreadyAddedBehaviors || !day.has(logged: behavior) {
						Button(action: { selectBehavior(behavior) }) {
							HStack() {
								VStack(alignment: .leading) {
									Text(behavior.title)
									if let addedAt = day.logged(behaviorAt: behavior) {
										Text(addedAt.localTimeString(date: .none))
											.font(.caption)
									}
								}
								.frame(maxWidth: .infinity, alignment: .leading)
								.opacity(day.has(logged: behavior) ? 0.5 : 1)
								.padding(5)
								Spacer()
								ValueView(behavior: behavior)
									.padding(5)
							}
						}
						.buttonStyle(.plain)
						Divider()
					}
				}
			}
		}
		.onAppear {
			if behaviors.isEmpty { BehaviorMO.importDefaults(into: context) }
		}
	}
}

//struct BehaviorListView_Previews: PreviewProvider {
//	static var previews: some View {
//		BehaviorListView()
//	}
//}
