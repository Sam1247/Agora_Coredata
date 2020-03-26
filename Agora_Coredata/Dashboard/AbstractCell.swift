//
//  ElectionCell.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct AbstractCell: View {
    //let election: Election
    let labelname: String
    let color: Color
    let systemNameIcon: String
    var body: some View {
        HStack {
            Image(systemName: systemNameIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundColor(color)
            Text(labelname)
            Spacer()
        }
    }
}
