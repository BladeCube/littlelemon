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
let uPhone="email key"
let uLoggedIn="uLoggedIn"
struct Onboarding: View {
    @State var firstName:String=""
    @State var lastName:String=""
    @State var email:String=""
    @State var phone:String=""
    @State var isLoggedIn=false
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Image("Logo")
                    .padding(.leading, 100)
                ZStack{
                    let color=Color(red: 73/255, green: 94/255, blue: 87/255)
                    Rectangle()
                        .fill(color)
                        .frame(width:400, height: 250)
                        .offset(y:-20)
                        //.padding(.bottom, 220)
                    HStack{
                        VStack(alignment: .leading){
                            Text("Little Lemon")
                            //.frame(alignment: .topLeading)
                                .position(x:130, y:30)
                                .foregroundColor(.yellow)
                                .font(.custom("MarkaziText-Medium", fixedSize: 50))
                            //.font(.system(size: 40).bold())
                            
                            Text("Chicago")
                                .position(x:70,y:-30)
                                .foregroundColor(.white)
                                .font(.custom("MarkaziText-Medium", fixedSize: 35))
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes with a modern twist")
                                .frame(width:200, height: 200)
                                .position(x:120, y:-30)
                                .foregroundColor(.white)
                                .font(.custom("Karla-Regular", fixedSize: 20))
                        }
                        Image("Hero image")
                            .resizable()
                            .frame(width: 100, height: 150)
                            .padding(.trailing, 10)
                            //.padding(.bottom, 300)
                        //.position(x:120, y:120)
                        
                    }
                }
                NavigationLink(destination: Home(), isActive: $isLoggedIn, label: {
                    EmptyView()
                })
                Divider()
                Text("First Name")
                    .padding(.leading, 10)
                    .font(.custom("Karla-Regular", fixedSize: 20))
                TextField("first name", text:$firstName)
                    .padding(.leading, 10)
                    .textFieldStyle(.roundedBorder)
                Divider()
                Text("Last Name")
                    .font(.custom("Karla-Regular", fixedSize: 20))
                    .padding(.leading, 10)
                TextField("last name", text:$lastName)
                    .padding(.leading, 10)
                    .textFieldStyle(.roundedBorder)
                Divider()
                Text("Email")
                    .font(.custom("Karla-Regular", fixedSize: 20))
                    .padding(.leading, 10)
                TextField("email", text:$email)
                    .padding(.leading, 10)
                    .textFieldStyle(.roundedBorder)
                Divider()
                Text("Phone")
                    .font(.custom("Karla-Regular", fixedSize: 20))
                    .padding(.leading, 10)
                TextField("phone number", text:$phone)
                    .padding(.leading, 10)
                    .textFieldStyle(.roundedBorder)
                Divider()
                //Text(String(!uFirst.isEmpty && !uLast.isEmpty && !uEmail.isEmpty))
                Button(action: {if (!uFirst.isEmpty && !uLast.isEmpty && !uEmail.isEmpty){
                    UserDefaults.standard.set(firstName, forKey: "uFirst")
                    UserDefaults.standard.set(lastName, forKey: "uLast")
                    UserDefaults.standard.set(email, forKey: "uEmail")
                    UserDefaults.standard.set(phone, forKey: "uPhone")
                    UserDefaults.standard.set(true, forKey: "uLoggedIn")
                    isLoggedIn=true;
                }
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 237/255, green: 239/255, blue: 238/255))
                            .frame(width:200, height: 40)
                        Text("Register")
                            .font(.custom("Karla-Regular", fixedSize: 24))
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    }
                        .padding(.leading, 100)
                        .offset(y:20)
                        //.padding(.bottom, -20)
                        
                    }
                
            }.onAppear(perform: {
                if (UserDefaults.standard.bool(forKey: "uLoggedIn")){
                    isLoggedIn=true
                }
            })
            .padding(.bottom, 30)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Onboarding()
}
