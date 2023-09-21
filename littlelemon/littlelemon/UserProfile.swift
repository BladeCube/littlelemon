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
    let phone=UserDefaults.standard.string(forKey: "uPhone")
    @State var uFirst: String
    @State var uLast: String
    @State var uEmail: String
    @State var uPhone: String
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(alignment: .leading){
            Image("Logo").padding(.leading, 80)
            
            Divider()
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 80, height: 80)
            Text("First Name")
            TextField("", text: $uFirst)
                .textFieldStyle(.roundedBorder)
                .frame(width:350)
                .padding(.bottom, 25)
            //Text(fName ?? "")
            Text("Last Name")
            TextField("", text: $uLast)
                .textFieldStyle(.roundedBorder)
                .frame(width:350)
                .padding(.bottom, 25)
            //Text(lName ?? "")
            Text("Email")
            TextField("", text: $uEmail)
                .textFieldStyle(.roundedBorder)
                .frame(width:350)
                .padding(.bottom, 25)
            //Text(email ?? "")
            Text("Phone")
            TextField("", text: $uPhone)
                .textFieldStyle(.roundedBorder)
                .frame(width:350)
                .padding(.bottom, 10)
            //Text(phone ?? "")
            Text("Email Notifications")
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "uLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }){
                Text("Logout")
            }
            Spacer()
        }.onAppear(perform:{
            self.uFirst=fName ?? ""
            self.uLast=lName ?? ""
            self.uEmail=email ?? ""
            self.uPhone=phone ?? ""
        })
        .padding(.leading,20)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    UserProfile(uFirst: "", uLast: "", uEmail: "", uPhone: "")
}
