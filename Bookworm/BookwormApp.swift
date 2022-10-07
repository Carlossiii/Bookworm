//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Carlos Vinicius on 06/10/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
