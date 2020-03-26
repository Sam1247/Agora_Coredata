//
//  ElectionList.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI
import CoreData

struct ElectionList: View {
    
    var body: some View {
        List {
            Section (header: ElectionListHeader()) {
                AbstractCell(labelname: "candidate.name", color: Color.init(.systemGreen), systemNameIcon: "person.circle.fill")
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Elections", displayMode: .inline)
    }
}

struct ElectionListHeader: View {
    var body: some View {
        HStack (alignment: .center){
            Text("Pending")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color.init(.label))
            
            Image(systemName: "clock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundColor(.yellow)
            
        }.padding(.top)
    }
}


struct ElectionList_Previews: PreviewProvider {
    static var previews: some View {
        ElectionList()
    }
}
