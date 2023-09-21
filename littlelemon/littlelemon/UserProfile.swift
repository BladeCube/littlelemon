//
//  UserProfile.swift
//  littlelemon
//
//  Created by Mark Chen on 9/19/23.
//

import SwiftUI

struct UserProfile: View {
    
    @State var orderCheck=UserDefaults.standard.bool(forKey: "order")
    @State var passwordCheck=UserDefaults.standard.bool(forKey: "password")
    @State var offerCheck=UserDefaults.standard.bool(forKey: "offer")
    @State var newsCheck=UserDefaults.standard.bool(forKey: "news")
    @State var usFirst: String=""
    @State var usLast: String=""
    @State var usEmail: String=""
    @State var usPhone: String=""
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Image(systemName: "arrowshape.turn.up.left.circle.fill")
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    }//.padding(.leading, 25)
                    
                    Image("Logo").padding(.leading, 50)
                }
               // Text(String(UserDefaults.standard.bool(forKey: "order")))
                Divider()
                Text("Personal information")
                    .font(.custom("Karla-Regular", fixedSize: 20))
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("First Name")
                    .font(.custom("Karla-Regular", fixedSize: 16))
                TextField("", text: $usFirst)
                    .font(.custom("Karla-Regular", fixedSize:16))
                    .textFieldStyle(.roundedBorder)
                    .frame(width:350)
                //.padding(.bottom, 15)
                //Text(fName ?? "")
                Text("Last Name")
                    .font(.custom("Karla-Regular", fixedSize: 16))
                TextField("", text: $usLast)
                    .font(.custom("Karla-Regular", fixedSize: 16))
                    .textFieldStyle(.roundedBorder)
                    .frame(width:350)
                //.padding(.bottom, 15)
                //Text(lName ?? "")
                Text("Email")
                    .font(.custom("Karla-Regular", fixedSize: 16))
                TextField("", text: $usEmail)
                    .font(.custom("Karla-Regular", fixedSize: 16))
                    .textFieldStyle(.roundedBorder)
                    .frame(width:350)
                //.padding(.bottom, 15)
                //Text(email ?? "")
                Text("Phone")
                    .font(.custom("Karla-Regular", fixedSize: 16))
                TextField("", text: $usPhone)
                    .font(.custom("Karla-Regular", fixedSize: 16))
                    .textFieldStyle(.roundedBorder)
                    .frame(width:350)
                    .padding(.bottom, 10)
                //Text(phone ?? "")
                Divider()
                Text("Email Notifications")
                    .font(.custom("Karla-Regular", fixedSize: 20))
                Toggle(isOn: $orderCheck){
                    Text("Order statuses")
                }.padding(.trailing, 10)
                Toggle(isOn: $passwordCheck){
                    Text("Password changes")
                }.padding(.trailing, 10)
                Toggle(isOn: $offerCheck){
                    Text("Special Offers")
                }.padding(.trailing, 10)
                Toggle(isOn: $newsCheck){
                    Text("Newsletter")
                }.padding(.trailing, 10)
                NavigationLink(destination: Onboarding()){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.yellow)
                            .frame(width:300, height: 40)
                        Text("Logout")
                            .font(.custom("Karla-Regular", fixedSize: 20))
                            .foregroundColor(.black)
                    }
                }.simultaneousGesture(TapGesture().onEnded{
                    UserDefaults.standard.set(false, forKey: "uLoggedIn")
                }).padding(.leading, 25)
                /*Button(action: {
                    
                    self.presentation.wrappedValue.dismiss()
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.yellow)
                            .frame(width:300, height: 40)
                        Text("Logout")
                            .font(.custom("Karla-Regular", fixedSize: 20))
                            .foregroundColor(.black)
                    }
                }.padding(.leading, 25)*/
                HStack{
                    Button(action: {
                        //UserDefaults.standard.set(false, forKey: "uLoggedIn")
                        
                        self.presentation.wrappedValue.dismiss()
                    }){
                        //ZStack{
                        
                        //.border(Color(red: 73/255, green: 94/255, blue: 87/255))
                        Text("Discard Changes")
                            .font(.custom("Karla-Regular", fixedSize: 16))
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(red: 73/255, green: 94/255, blue: 87/255), lineWidth: 5)
                                    .frame(width:160, height: 40)
                            )
                        //}
                    }.padding(.leading, 20)
                    Button(action: {
                        UserDefaults.standard.set(orderCheck, forKey: "order")
                        UserDefaults.standard.set(passwordCheck, forKey: "password")
                        UserDefaults.standard.set(offerCheck, forKey: "offer")
                        UserDefaults.standard.set(newsCheck, forKey: "news")
                        //print(String(UserDefaults.standard.bool(forKey: "news")))
                        UserDefaults.standard.set(usFirst, forKey: "uFirst")
                        UserDefaults.standard.set(usLast, forKey: "uLast")
                        UserDefaults.standard.set(usEmail, forKey: "uEmail")
                        UserDefaults.standard.set(usPhone, forKey: "uPhone")
                        self.presentation.wrappedValue.dismiss()
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 73/255, green: 94/255, blue: 87/255))
                                .frame(width:160, height: 40)
                            Text("Save Changes")
                                .font(.custom("Karla-Regular", fixedSize: 16))
                                .foregroundColor(.white)
                        }
                    }.padding(.leading, 25)
                }
                Spacer()
            }.onAppear(perform:{
                self.usFirst=UserDefaults.standard.string(forKey: "uFirst") ?? ""
                self.usLast=UserDefaults.standard.string(forKey: "uLast") ?? ""
                self.usEmail=UserDefaults.standard.string(forKey: "uEmail") ?? ""
                self.usPhone=UserDefaults.standard.string(forKey: "uPhone") ?? ""
                self.orderCheck=UserDefaults.standard.bool(forKey: "order")
                self.passwordCheck=UserDefaults.standard.bool(forKey: "password")
                self.offerCheck=UserDefaults.standard.bool(forKey: "offer")
                self.newsCheck=UserDefaults.standard.bool(forKey: "news")
            })
            .padding(.leading,20)
            .navigationBarBackButtonHidden(true)
            .background(
                Image("Little Lemon logo")
                    .resizable()
                    .grayscale(0.7)
                
                    .frame(width: 500, height: 1400)
            )
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    UserProfile(usFirst: "", usLast: "", usEmail: "", usPhone: "")
}
