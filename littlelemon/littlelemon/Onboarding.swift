//
//  SwiftUIView.swift
//  littlelemon
//
//  Created by Mark Chen on 9/19/23.
//

import SwiftUI
let uFirst="first name key"
let uLast="last name key"
let uEmail="email key"
let uLoggedIn="uLoggedIn"
struct Onboarding: View {
    @State var firstName:String=""
    @State var lastName:String=""
    @State var email:String=""
    @State var isLoggedIn=false
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: Home(), isActive: $isLoggedIn, label: {
                    EmptyView()
                })
                TextField("first name", text:$firstName)
                TextField("last name", text:$lastName)
                TextField("email", text:$email)
                //Text(String(!uFirst.isEmpty && !uLast.isEmpty && !uEmail.isEmpty))
                Button(action: {if (!uFirst.isEmpty && !uLast.isEmpty && !uEmail.isEmpty){
                    UserDefaults.standard.set(firstName, forKey: "uFirst")
                    UserDefaults.standard.set(lastName, forKey: "uLast")
                    UserDefaults.standard.set(email, forKey: "uEmail")
                    UserDefaults.standard.set(true, forKey: "uLoggedIn")
                    isLoggedIn=true;
                }
                }){
                        Text("Register")
                        
                    }
                
            }.onAppear(perform: {
                if (UserDefaults.standard.bool(forKey: "uLoggedIn")){
                    isLoggedIn=true
                }
            })
        }
    }
}

#Preview {
    Onboarding()
}
