//
//  html_researchApp.swift
//  html-research
//
//  Created by Alexey Agapov on 09.08.2022.
//

import SwiftUI
import XCTestDynamicOverlay

@main
struct html_researchApp: App {
    var body: some Scene {
        WindowGroup {
            if _XCTIsTesting {
                EmptyView()
            } else {
                ContentView()
            }
        }
    }
}
