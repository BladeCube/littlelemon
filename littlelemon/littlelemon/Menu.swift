//
//  Menu.swift
//  littlelemon
//
//  Created by Mark Chen on 9/19/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack{
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes with a modern twist")
            List{}
            
        }
    }
}

#Preview {
    Menu()
}
