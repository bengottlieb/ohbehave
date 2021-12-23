//
//  NSManagedObjectContext+Behave.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import CoreData
import Suite

extension NSManagedObjectContext {
	func behavior(with id: String) -> BehaviorMO? {
		let pred = NSPredicate(format: "stringID == %@", id)
		let result: BehaviorMO? = self.fetchAny(matching: pred)
		return result
	}
}
