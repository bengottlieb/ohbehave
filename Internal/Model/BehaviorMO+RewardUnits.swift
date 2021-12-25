//
//  DayMO+RewardUnits.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/23/21.
//

import SwiftUI

extension BehaviorMO {
	public enum RewardUnit: String { case iPadTime = "iPad time", computerTime = "computer timer"
		public var abbreviation: String {
			switch self {
			case .iPadTime: return "iPad min"
			case .computerTime: return "comp min"
			}
		}
		
		public var color: Color {
			switch self {
			case .iPadTime: return .green
			case .computerTime: return .blue
			}
		}
	}
	public var rewardUnit: RewardUnit { RewardUnit(rawValue: unitString ?? "") ?? .computerTime }
}
