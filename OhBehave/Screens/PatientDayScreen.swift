//
//  PatientDayScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct PatientDayScreen: View {
	@ObservedObject var day: DayMO
	
	@State var addingBehavior = false
	
	var body: some View {
		VStack() {
			
		}
		.navigationTitle(day.dayTitle)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: addBehavior) { Image(.plus).padding() }
			}
		}
		
		NavigationLink(destination: AddBehaviorScreen(day: day), isActive: $addingBehavior) { EmptyView() }
	}
	
	func addBehavior() {
		addingBehavior.toggle()
	}
}

//struct PatientDayScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		PatientDayScreen()
//	}
//}
