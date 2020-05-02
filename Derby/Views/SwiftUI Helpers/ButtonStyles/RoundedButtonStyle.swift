//
//  RoundedButtonStyle.swift
//  Derby
//
//  Created by Ben Hollar on 5/1/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import SwiftUI

struct RoundedButonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .foregroundColor(Color("DerbyPurple"))
            .font(.system(size: 24, weight: .bold, design: .default))
            .cornerRadius(30)
    }
}
