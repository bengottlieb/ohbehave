//
//  PatientDayScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Internal

struct PatientDayScreen: View {
	@ObservedObject var day: DayMO
	
	@State var editPatient = false
	@State var addingBehavior = false
	
	var body: some View {
		VStack() {
			RecordedBehaviorListView(day: day)
			HStack() {
				Text("Total for day")
				Spacer()
				VStack(alignment: .trailing) {
					Text("Computer: \(TimeInterval(day.totalEarned(for: .computerTime) * 60).durationString(style: .minutes))")
						.bold()

					Text("iPad: \(TimeInterval(day.totalEarned(for: .iPadTime) * 60).durationString(style: .minutes))")
						.bold()
				}
			}
			.padding()
		}
		.navigationTitle(day.dayTitle)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: { editPatient.toggle() }) { Image(.gear) }
			}
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: addBehavior) { Image(.plus) }
			}
		}
		
		if let patient = day.patient {
			NavigationLink(destination: PatientDetailsScreen(patient: patient), isActive: $editPatient) { EmptyView() }
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
