//
//  PatientListScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct PatientListScreen: View {
	var body: some View {
		NavigationView() {
			VStack() {
				PatientListTable()
			}
		}
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct PatientListScreen_Previews: PreviewProvider {
	static var previews: some View {
		PatientListScreen()
	}
}
