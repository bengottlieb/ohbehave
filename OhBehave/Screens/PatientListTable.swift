//
//  PatientListTable.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite
import Internal
import Cirrus
import CloudKit

struct PatientListTable: View {
	@Environment(\.managedObjectContext) var context
	@FetchRequest(entity: PatientMO.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PatientMO.name, ascending: false)]) var patients: FetchedResults<PatientMO>
	
	var body: some View {
		ScrollView() {
			VStack() {
				ForEach(patients) { patient in
					NavigationLink(destination: PatientScreen(patient: patient)) {
						HStack() {
							Text(patient.name)
								.font(.title)
							
							Spacer()
							
							Button(action: {
								Task {
									try? await CKRecord(patient)?.share(withTitle: "Sharing access to \(patient.name)", permissions: .readWrite, in: UIApplication.shared.currentScene?.frontWindow)
								}}) {
									Image(.square_and_arrow_up)
										.padding()
								}
							
						}
						.padding()
					}
				}
			}
		}
		.navigationTitle("Patients")
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button(action: addPatient) { Image(.plus).padding() }
			}
			ToolbarItem(placement: .navigationBarTrailing) {
				Menu {
					Button("Update Behaviors") { DataStore.instance.updateBehaviors() }
				} label: {
					Image(.gear).padding()
				}
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
