//
//  ElectionDetail.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/24/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct ElectionDetail: View {
    var election: Election
    var body: some View {
        List {
            Section (header: DetailHeader(election: election)
                .foregroundColor(.black)
            ) {
                EmptyView()
            }
            Section(header: CandidatesHeader()) {
                ForEach((self.election.candidates?.allObjects as? [Candidate])!, id: \.uid) { candidate in
                    AbstractCell(labelname: candidate.name!, color: Color.init(.systemYellow), systemNameIcon: "person.circle.fill")
                }
            }
            Section (header: DeleteButton()) {
                EmptyView()
            }
            
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Election", displayMode: .large)
    }
}

struct CandidatesHeader: View {
    var body: some View {
        HStack (alignment: .center){
            Text("Candidates")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color.init(.label))
            
        }
    }
}

struct DeleteButton: View {
    @State var showingDeleteAlert = false
    var body: some View {
        Button (action: {
            self.showingDeleteAlert.toggle()
        }) {
            AbstractButtonView(color: Color.init(.systemRed), label: "Delete")
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Are you sure you want to delete this election?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
            }, secondaryButton: .cancel())
        }
        
    }
}

struct DetailHeader: View {
    let padding: CGFloat = 20
    var election: Election
     
    var body: some View {
        
        VStack (spacing: 12) {
            
            ElectionHeader(election: election)
            
            ElectionDateHeader(election: election)
            
            Button(action: {
                
            }) {
                Text("Result")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: 375, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.init(.systemGreen))
                        )
            }
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        
                        DetailSmallICon(iconName: "archivebox.fill", label: "Ballot")
                        .frame(width: getSmallCellWidth(), height: 50)
                        .background(Color.init(.tertiarySystemBackground))
                        .cornerRadius(8)
                        
                        
                    }
                    
                    Button(action: {
                        
                    }) {
                        DetailSmallICon(iconName: "plus.app.fill", label: "Invite Voters")
                            .frame(width: getSmallCellWidth(), height: 50)
                            .background(Color.init(.tertiarySystemBackground))
                            .cornerRadius(8)
                        
                    }
                    
                    Button(action: {
                        
                    }) {
                        DetailSmallICon(iconName: "rectangle.stack.person.crop.fill", label: "Voters")
                            .frame(width: getSmallCellWidth(), height: 50)
                            .background(Color.init(.tertiarySystemBackground))
                            .cornerRadius(8)
                    }
                    
                }
            }
            
            
        }
    }
    
    func getSmallCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 14 * 4) / 3
    }
    
    func getLargeCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 12 * 2)
    }
    
    func getScreenWidth () -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDateCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 12 * 2) / 2
    }
}


struct DetailSmallICon: View {
    let iconName: String
    let label: String
    let color = Color.init(.systemGreen)
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .foregroundColor(color)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                
            Text(label)
                .font(.caption)
                .foregroundColor(color)
        }
    }
}


struct ElectionHeader: View {
    var election: Election
    //let election = allElectionData[0]
    var body: some View {
        VStack (alignment: .leading){
            HStack(alignment: .center) {
               
                Text(election.name ?? "unknown name")
                    .foregroundColor(Color.init(.label))
                    .font(.headline).bold()
                
                Text("(Active)")
                    .font(.footnote)
                    .foregroundColor(Color.init(.systemBlue))
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .foregroundColor(Color.init(.systemGreen))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
            }
            
            Text(election.des ?? "unknown description")
                .font(.body)
                .foregroundColor(Color.init(.systemGray))
        }//.background(Color.red)
    }
}



struct ElectionDateHeader: View {
    let padding: CGFloat = 20
    var election: Election
    var body: some View {
        HStack {
            
            ElectionDateCell(kind: "Start Date", date: "31 March 2020", dateHour: "04:00 AM")
            
            Spacer()
            ElectionDateCell(kind: "End Date", date: "21 May 2020", dateHour: "06:00 PM")

        }
        .frame(width: getScreenWidth() - padding*2)
        .padding(.top)
    }
    
    func getSmallCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 14 * 4) / 3
    }
    
    func getLargeCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 12 * 2)
    }
    
    func getScreenWidth () -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDateCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 12 * 2) / 2
    }
}



struct ElectionDateCell: View {
    let kind: String
    let date: String
    let dateHour: String
    let padding: CGFloat = 20
    var body: some View {
        HStack {
            VStack {
                Text(kind)
                    .font(.headline)
                    .foregroundColor(Color.init(.systemGray))
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(Color.init(.label))
                    .bold()
                Text(dateHour)
                    .font(.subheadline)
                    .foregroundColor(Color.init(.label))
                    .bold()

            }
            .padding()
            .frame(width: (getScreenWidth() - padding*2 - 12)/2)
            .background(Color.init(.tertiarySystemBackground))
            .cornerRadius(12)
        }
    }
    
    func getSmallCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 14 * 4) / 3
    }
    
    func getLargeCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 12 * 2)
    }
    
    func getScreenWidth () -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDateCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 12 * 2) / 2
    }
}
