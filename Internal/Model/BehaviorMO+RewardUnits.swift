//
//  DayMO+RewardUnits.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/23/21.
//

import Foundation

extension BehaviorMO {
	public enum RewardUnit: String { case screenTime = "screen time"
		public var abbreviation: String {
			switch self {
			case .screenTime: return "min"
			}
		}
	}
	public var rewardUnit: RewardUnit { RewardUnit(rawValue: unitString ?? "") ?? .screenTime }
}
