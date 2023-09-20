//
//  UserProfile.swift
//  littlelemon
//
//  Created by Mark Chen on 9/19/23.
//

import SwiftUI

struct UserProfile: View {
    let fName=UserDefaults.standard.string(forKey: "uFirst")
    let lName=UserDefaults.standard.string(forKey: "uLast")
    let email=UserDefaults.standard.string(forKey: "uEmail")
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(fName ?? "")
            Text(lName ?? "")
            Text(email ?? "")
            Button(action: {
                UserDefaults.standard.set(false, forKey: "uLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }){
                Text("Logout")
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
