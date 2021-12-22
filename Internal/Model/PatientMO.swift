//
//  Patient.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Foundation
import Cirrus
import CloudKit


public class PatientMO: SyncedManagedObject {
	@NSManaged public var uuid: String
	@NSManaged public var name: String
	@NSManaged public var age: Int16
	@NSManaged public var days: Set<DayMO>
	
	override public var database: CKDatabase { .private }
	
	public var today: DayMO {
		for day in days {
			if day.isToday { return day }
		}
		
		let day: DayMO = self.moc!.insertObject()
		
		day.patient = self
		day.save()
		
		return day
	}
}
