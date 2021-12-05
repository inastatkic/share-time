// Created by Ina Statkic in 2021. 
// Copyright © 2021 Ina. All rights reserved.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var actionManager: ActionManager
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            if actionManager.actions.isEmpty {
                VStack {
                    Text("No Time").padding()
                    NewAction(text: $text)
                }
                .navigationTitle("Actions")
            } else {
                List {
                    ForEach(actionManager.actions) { action in
                        Text(action.title)
                            .listRowBackground(Color.clear)
                    }
                    NewAction(text: $text)
                }
                .listStyle(.carousel)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ActionManager())
    }
}
