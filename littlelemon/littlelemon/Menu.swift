//
//  Menu.swift
//  littlelemon
//
//  Created by Mark Chen on 9/19/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String
    @State var buttonText: String
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Image("Logo")
                    Spacer()
                    
                    NavigationLink(destination: UserProfile(uFirst: "", uLast: "", uEmail: "", uPhone: "")){
                        Image("profile-image-placeholder")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                    
                }
                
                ZStack{
                    let color=Color(red: 73/255, green: 94/255, blue: 87/255)
                    Rectangle().fill(color)
                    HStack{
                        VStack(alignment: .leading){
                            Text("Little Lemon")
                            //.frame(alignment: .topLeading)
                                .position(x:130, y:25)
                                .foregroundColor(.yellow)
                                .font(.custom("MarkaziText-Medium", fixedSize: 50))
                            //.font(.system(size: 40).bold())
                            
                            Text("Chicago")
                                .position(x:70, y:-20)
                                .foregroundColor(.white)
                                .font(.custom("MarkaziText-Medium", fixedSize: 35))
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes with a modern twist")
                                .frame(width:200, height: 200)
                                .position(x:120, y:-10)
                                .foregroundColor(.white)
                                .font(.custom("Karla-Regular", fixedSize: 20))
                            
                            TextField("Search menu", text:$searchText)
                                .background(Color.white)
                                .position(x: 160, y:20)
                        }
                        Image("Hero image")
                            .resizable()
                            .frame(width: 100, height: 150)
                            .padding(.trailing, 10)
                        //.position(x:120, y:120)
                        
                    }
                }
                Text("Order for delivery")
                    .font(.custom("Karla-Regular", fixedSize: 30))
                HStack{
                    Button(action: {
                        buttonText="starters"
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 237/255, green: 239/255, blue: 238/255))
                                .frame(width:70, height: 40)
                            Text("Starters")
                                .font(.custom("Karla-Regular", fixedSize: 16))
                                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        }
                    }
                    Button(action: {
                        buttonText="mains"
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 237/255, green: 239/255, blue: 238/255))
                                .frame(width:70, height: 40)
                            Text("Mains")
                                .font(.custom("Karla-Regular", fixedSize: 16))
                                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        }
                    }
                    Button(action: {
                        buttonText="desserts"
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 237/255, green: 239/255, blue: 238/255))
                                .frame(width:70, height: 40)
                            Text("Desserts")
                                .font(.custom("Karla-Regular", fixedSize: 16))
                                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        }
                    }
                    Button(action: {
                        buttonText="sides"
                    }){
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 237/255, green: 239/255, blue: 238/255))
                                .frame(width:70, height: 40)
                            Text("Sides")
                                .font(.custom("Karla-Regular", fixedSize: 16))
                                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        }
                    }
                }
                //Text(buttonText)
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List{
                        ForEach(dishes){ dish in
                            if (dish.category==buttonText){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("\(dish.title!)")
                                            .font(.custom("Karla-Regular", fixedSize: 20))
                                        ScrollView{
                                            Text("\(dish.descript!)")
                                                .font(.custom("Karla-Regular", fixedSize: 16))
                                                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                        }
                                        Text("$\(dish.price!)")
                                            .font(.custom("Karla-Regular", fixedSize: 16))
                                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                    }
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image!)){ image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: 100, height: 100, alignment: .trailing)
                                    //.position(x: 100, y: 50)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                }
            }.onAppear(perform: {
                getMenuData()
            })
            .onDisappear(perform: {
                PersistenceController.shared.clear()
            })
        }
    }

    func getMenuData(){
        PersistenceController.shared.clear()
        let url="https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuURL=URL(string: url)!
        let request=URLRequest(url: menuURL)
        let task=URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data, let str=try? JSONDecoder().decode(MenuList.self, from: data){
                let menuItems=str.menu
                //print(menuItems)
                //var i=0
                menuItems.forEach{ menu in
                    let dish=Dish(context:viewContext)
                    print(menu.category)
                    dish.title = menu.title
                    dish.category=menu.category
                    dish.image = menu.image
                    dish.price = menu.price
                    dish.descript=menu.description
                    //print(dish.category)
                    try? viewContext.save()
                    //catch print("XD")
                }
                
            }
        }
        task.resume()
    }
    func buildPredicate()->NSPredicate{
        if (searchText.isEmpty){
            return NSPredicate(value:true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    func buildSortDescriptors() -> [NSSortDescriptor]{
        
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
}



#Preview {
    Menu(searchText: "", buttonText: "")
}
