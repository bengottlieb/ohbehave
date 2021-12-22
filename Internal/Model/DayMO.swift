//
//  Day.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Foundation
import Cirrus

public class DayMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var title: String
	@NSManaged public var date: Date
}
