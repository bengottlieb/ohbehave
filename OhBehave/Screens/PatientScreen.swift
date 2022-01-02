//
//  PatientScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/25/21.
//

import SwiftUI
import Internal

struct PatientScreen: View {
	@ObservedObject var patient: PatientMO
	@State var day: DayMO?
	
    var body: some View {
		 VStack() {
			 if let day = day {
				 PatientDayScreen(day: day)
			 }
		 }
		 .onAppear {
			 day = patient.today
		 }
	 }
}

//struct PatientScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PatientScreen()
//    }
//}
