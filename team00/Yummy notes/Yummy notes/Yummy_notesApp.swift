import SwiftUI

@main
struct Yummy_notesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .tint(.green)
        }
    }
}
