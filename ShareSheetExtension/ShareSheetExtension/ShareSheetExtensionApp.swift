//
//  ShareSheetExtensionApp.swift
//  ShareSheetExtension
//
//  Created by mac on 30/01/24.
//

import SwiftUI

@main
struct ShareSheetExtensionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ImageItem.self)
    }
}
