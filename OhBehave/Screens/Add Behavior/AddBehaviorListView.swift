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
	
	let selectBehavior: (BehaviorMO) -> Void
	
	var body: some View {
		ScrollView() {
			VStack() {
				ForEach(behaviors) { behavior in
					if !hideAlreadyAddedBehaviors || !day.has(logged: behavior) || behavior.earnedMultipleTimes {
						AddBehaviorRow(behavior: behavior, day: day, selectBehavior: selectBehavior)
						.buttonStyle(.plain)
						Divider()
					}
				}
			}
		}
		.onAppear {
			#if targetEnvironment(simulator)
				BehaviorMO.importDefaults(into: context)
			#endif
		}
	}
}

//struct BehaviorListView_Previews: PreviewProvider {
//	static var previews: some View {
//		BehaviorListView()
//	}
//}
