//
//  AddBehaviorScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct AddBehaviorScreen: View {
	@State var hideAlreadyAddedBehaviors = false
	
	@ObservedObject var day: DayMO
	var body: some View {
		VStack() {
			AddBehaviorListView(day: day, hideAlreadyAddedBehaviors: $hideAlreadyAddedBehaviors) { behavior in
				day.log(behavior: behavior)
				day.save()
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button(action: { hideAlreadyAddedBehaviors.toggle() }) { Text(hideAlreadyAddedBehaviors ? "Show Added" : "Hide Added" ) }
			}
		}
	}
}
