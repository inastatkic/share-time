// Created by Ina Statkic in 2021.
// Copyright © 2021 Ina. All rights reserved.

import SwiftUI

struct NewAction: View {
    @EnvironmentObject var actionManager: ActionManager
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text)
            .multilineTextAlignment(.center)
            .foregroundColor(.accentColor)
            .inputButton(when: text.isEmpty) {
                Text("New Action")
                    .foregroundColor(.accentColor)
            }
            .onSubmit {
                actionManager.addAction(title: text)
            }
    }
}

struct NewAction_Previews: PreviewProvider {
    static var previews: some View {
        NewAction(text: .constant("Extend healthspan"))
            .environmentObject(ActionManager())
    }
}
