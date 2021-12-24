//
//  BehaviorInfo.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite

struct BehaviorInfo: Codable, Equatable {
	var kinds: [String]
	var times: [String]
	var title: String
	var description: String?
	var value: Int
	var unit: String
	var earnedIfCompletedAt: Date.Time?
	var earnedUnlessLost: Bool?
	var earnedMultipleTimes: Bool?

	var id: String {
		"default-" + title
	}
	
	static func ==(lhs: BehaviorInfo, rhs: BehaviorInfo) -> Bool {
		lhs.kinds == rhs.kinds &&
		lhs.times == rhs.times &&
		lhs.title == rhs.title &&
		lhs.description == rhs.description &&
		lhs.value == rhs.value &&
		lhs.unit == rhs.unit &&
		lhs.earnedIfCompletedAt == rhs.earnedIfCompletedAt &&
		(lhs.earnedUnlessLost ?? false) == (rhs.earnedUnlessLost ?? false) &&
		(lhs.earnedMultipleTimes ?? false) == (rhs.earnedMultipleTimes ?? false)
	}
}

extension BehaviorInfo {
	static var defaultBehaviors: [BehaviorInfo] {
		try! [BehaviorInfo].loadJSON(file: Bundle.main.url(forResource: "default_behaviors", withExtension: "json"))
	}
}
