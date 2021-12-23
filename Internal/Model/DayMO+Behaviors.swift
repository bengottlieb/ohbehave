//
//  DayMO+Behaviors.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/23/21.
//

import Suite
import CoreData
import Journalist

extension DayMO {
	public func has(logged behavior: BehaviorMO) -> Bool {
		loggedBehaviors.contains { $0.behaviorID == behavior.stringID }
	}
	
	public func logged(behaviorAt behavior: BehaviorMO) -> Date? {
		if let index = loggedBehaviors.firstIndex(where: { $0.behaviorID == behavior.stringID }) {
			return loggedBehaviors[index].date
		}
		return nil
	}
	
	public func deleteBehaviors(at indexes: IndexSet) {
		var behaviors = loggedBehaviors
		behaviors.remove(atOffsets: indexes)
		self.loggedBehaviors = behaviors
	}
	
	public var loggedBehaviors: [LoggedBehavior] {
		get {
			if let cached = _loggedBehaviors { return cached }
			guard let data = behaviorData else { return [] }
			
			let result = report(note: "Failed to decode behaviors") {
				return try [LoggedBehavior].loadJSON(data: data)
			}
			
			_loggedBehaviors = result
			return result ?? []
		}
		
		set {
			_loggedBehaviors = newValue
			if let data = try? JSONEncoder().encode(newValue) {
				self.behaviorData = data
			}
		}
	}
	
	public func log(behavior: BehaviorMO) {
		var behaviors = self.loggedBehaviors
		
		behaviors.append(LoggedBehavior(behaviorID: behavior.stringID))
		self.loggedBehaviors = behaviors
	}
	
	public struct LoggedBehavior: Codable, Identifiable {
		public var id: String = UUID().uuidString
		public var behaviorID: String
		public var date: Date = Date()
		public var count: Int = 1
		
		public func behavior(in context: NSManagedObjectContext?) -> BehaviorMO? {
			context?.behavior(with: behaviorID)
		}
	}
}
