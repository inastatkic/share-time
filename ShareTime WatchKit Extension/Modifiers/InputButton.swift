// Created by Ina Statkic in 2021. 
// Copyright © 2021 Ina. All rights reserved.

import SwiftUI

extension View {
    func inputButton<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder input: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            input().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
