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
    var body: some View {
        VStack{
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes with a modern twist")
            
            TextField("Search menu", text:$searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
            //Text("HELP")
            //Text("\(dishes.count)")
            List{
                ForEach(dishes){ dish in
                    HStack{
                        Text("\(dish.title!): \(dish.price!)")
                        AsyncImage(url: URL(string: dish.image!)){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 100, height: 100)
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
                    //print(menu.price)
                    dish.title = menu.title
                    
                    dish.image = menu.image
                    dish.price = menu.price
                    //print(dish.price)
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



/*#Preview {
    Menu()
}*/
