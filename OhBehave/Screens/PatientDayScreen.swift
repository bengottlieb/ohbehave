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
	
	var body: some View {
		VStack() {
			
		}
		.navigationTitle(day.dayTitle)
	}
}

//struct PatientDayScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		PatientDayScreen()
//	}
//}
