//
//  ValueView.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/23/21.
//

import SwiftUI
import Internal

struct ValueView: View {
	let behavior: BehaviorMO
	
	var body: some View {
		HStack() {
			Text("\(behavior.pointsValue)")
			Text(behavior.rewardUnit.abbreviation)
		}
		.font(.system(size: 10, weight: .semibold))
		.padding(.vertical, 4)
		.padding(.horizontal, 6)
		.background(Capsule().fill(Color.black.opacity(0.1)))
	}
}

//struct ValueView_Previews: PreviewProvider {
//	static var previews: some View {
//		ValueView()
//	}
//}
