//
//  PatientDetailsScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct PatientDetailsScreen: View {
	@ObservedObject var patient: PatientMO
	var body: some View {
		VStack() {
			TextField("Name", text: $patient.name)
			
			HStack() {
				Text("Age: \(patient.age)")
				Stepper("", value: $patient.age)
			}
			Spacer()
		}
		.padding()
		.navigationTitle("Details")
		.onDisappear {
			patient.save()
		}
	}
}

//struct PatientDetailsScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		PatientDetailsScreen()
//	}
//}
