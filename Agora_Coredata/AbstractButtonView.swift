//
//  AbstractButton.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct AbstractButtonView: View {
    let color: Color
    let label: String
    var body: some View {
        Text(label)
           .font(.headline)
           .foregroundColor(.white)
           .bold()
           .frame(width: (UIScreen.main.bounds.width - 12 * 2) - 12, height: 52)
           .background(color)
           .cornerRadius(12)
    }
}
