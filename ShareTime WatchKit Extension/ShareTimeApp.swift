// Created by Ina Statkic in 2021. 
// 

import SwiftUI

@main
struct ShareTimeApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(ActionManager())
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
