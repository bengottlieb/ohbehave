//
//  ContentScreen.swift
//  OhBehave
//
//  Created by Ben Gottlieb on 12/22/21.
//

import SwiftUI
import Cirrus

struct ContentScreen: View {
    var body: some View {
		 CirrusStatusView() {
			 Text("Welcome to Oh, Behave!")
		 }
    }
}

struct ContentScreen_Previews: PreviewProvider {
    static var previews: some View {
		 ContentScreen()
    }
}
