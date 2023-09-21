//
//  Home.swift
//  littlelemon
//
//  Created by Mark Chen on 9/19/23.
//

import SwiftUI

struct Home: View {
    let persistence=PersistenceController.shared
    var body: some View {
        //TabView{
        Menu(searchText: "", buttonText: "starters")
                .environment(\.managedObjectContext, persistence.container.viewContext)
                /*.tabItem({
                    Label("Menu", systemImage:"list.dash")
                })*/
            /*UserProfile()
                .tabItem({
                    Label("Profile", systemImage:"square.and.pencil")
                })*/
        //}
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
