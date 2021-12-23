//
//  Settings.swift
//  Internal
//
//  Created by Ben Gottlieb on 12/22/21.
//

import Suite

public class Settings: DefaultsBasedPreferences {
	public static let instance = Settings()
	
	@objc public dynamic var lastSyncedBehaviorsAt: Date?
}
