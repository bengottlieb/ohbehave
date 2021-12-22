//
//  Child.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Foundation
import Cirrus


public class ChildMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var name: String
	@NSManaged public var age: Int16
}
