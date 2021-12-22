//
//  PatientListTable.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Internal

struct PatientListTable: View {
	@Environment(\.managedObjectContext) var context
	@FetchRequest(entity: PatientMO.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PatientMO.name, ascending: false)]) var patients: FetchedResults<PatientMO>
	
	var body: some View {
		ScrollView() {
			VStack() {
				ForEach(patients) { patient in
					NavigationLink(destination: Deferred { PatientDayScreen(day: patient.today) }) {
						Text(patient.name + " - " + patient.uuid)
					}
				}
			}
		}
		.navigationTitle("Patients")
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button(action: addPatient) { Image(.plus).padding() }
			}
		}
	}
	
	func addPatient() {
		let patient: PatientMO = context.insertObject()
		
		patient.name = "Unnamed Patient"
		context.saveContext()
	}
}

struct PatientListTable_Previews: PreviewProvider {
    static var previews: some View {
		 PatientListTable()
    }
}
