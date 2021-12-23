//
//  AddBehaviorScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct AddBehaviorScreen: View {
	@ObservedObject var day: DayMO
	var body: some View {
		VStack() {
			BehaviorListView()
		}
	}
}

//struct AddBehaviorScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		AddBehaviorScreen()
//	}
//}
