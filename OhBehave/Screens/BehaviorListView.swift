//
//  BehaviorListView.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Internal

struct BehaviorListView: View {
	@Environment(\.managedObjectContext) var context
	@FetchRequest(entity: BehaviorMO.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \BehaviorMO.title, ascending: true)]) var behaviors: FetchedResults<BehaviorMO>

	var body: some View {
		ScrollView() {
			VStack() {
				ForEach(behaviors) { behavior in
					Text(behavior.title)
				}
			}
		}
		.onAppear {
			if behaviors.isEmpty { BehaviorMO.importDefaults(into: context) }
		}
	}
}

struct BehaviorListView_Previews: PreviewProvider {
	static var previews: some View {
		BehaviorListView()
	}
}
