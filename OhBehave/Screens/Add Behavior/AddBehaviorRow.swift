//
//  AddBehaviorRow.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/24/21.
//

import Suite
import Internal
import Achtung
import UIKit

struct AddBehaviorRow: View {
	let behavior: BehaviorMO
	@ObservedObject var day: DayMO
	let selectBehavior: (BehaviorMO) -> Void
	
	func showDescription() {
		Achtung.instance.show(title: Text(behavior.title), message: Text(behavior.desc ?? ""), buttons: [Achtung.Button.default(Text("OK"))])
	}
	var hasDescription: Bool { behavior.desc?.isNotEmpty == true }
	var hasBeenEarned: Bool { !behavior.earnedMultipleTimes && day.has(logged: behavior) }
	var body: some View {
		HStack() {
			Button(action: {
				UIImpactFeedbackGenerator().impactOccurred()
				selectBehavior(behavior)
			}) {
				VStack(alignment: .leading) {
					HStack() {
						if behavior.canBeLost {
							Image(.xmark_circle)
								.foregroundColor(.red)
						}
						Text(behavior.title)
					}
					HStack() {
						if let addedAt = day.logged(behaviorAt: behavior) {
							let prefix = behavior.earnedUnlessLost ? "lost at " : "earned at "
							Text(prefix + addedAt.localTimeString(date: .none))
								.font(.caption)
								.opacity(hasBeenEarned ? 1 : 0.5)
								.foregroundColor(behavior.earnedUnlessLost ? .red : .black)
						}
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.opacity(hasBeenEarned ? 0.5 : 1)
				.padding(10)
				Spacer()
				HStack() {
					let count = day.count(of: behavior)
					if count > 1 {
						Text("\(count)x")
							.font(.title)
					}
					ValueView(behavior: behavior)
				}
				.padding(5)
			}
			.background(Color.white.opacity(0.01))
			
			Button(action: showDescription) { Image(.info).padding(.trailing) }
				.opacity(hasDescription ? 1 : 0)
				.background(Color.white.opacity(0.01))

		}
	}
}

//struct AddBehaviorRow_Previews: PreviewProvider {
//	static var previews: some View {
//		AddBehaviorRow()
//	}
//}
