//
//  BehaviorInfo.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite

struct BehaviorInfo: Codable {
	var kinds: [String]
	var times: [String]
	var title: String
	var description: String?
	var value: Int
	var unit: String
	var earnedIfCompletedAt: Date.Time?
	var earnedUnlessLost: Bool?
	
	var id: String {
		"default-" + title
	}
}

extension BehaviorInfo {
	static var defaultBehaviors: [BehaviorInfo] {
		try! [BehaviorInfo].loadJSON(file: Bundle.main.url(forResource: "default_behaviors", withExtension: "json"))
	}
}
