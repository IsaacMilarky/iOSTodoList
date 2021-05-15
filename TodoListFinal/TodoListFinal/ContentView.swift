//
//  ContentView.swift
//  TodoListFinal
//
//  Created by imfbp on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var itemsToDo: [ListItem] = []
    @State var title: String = ""
    @State var description: String = ""
    
    
    //Construct new list item from input data.
    func addItem(itemName: String, itemDesc: String)
    {
        //This would be a state variable but swiftUI doesn't support that
        //¯\_(ツ)_/¯
        let toAdd = ListItem(title: itemName, description: itemDesc, dateCreated: Date())
        
        itemsToDo.append(toAdd)
    }
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                //Pass state variable to bound view attribute for mutating item swipe deletion
                itemizedListView(itemsToDo: $itemsToDo)
                
                //Two inputs and a button is the interface.
                HStack {
                    
                    
                    VStack
                    {
                        TextField("Enter item title...", text: $title)
                            .padding(.horizontal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        
                        
                        TextField("Enter item description...", text: $description)
                            .padding(.horizontal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    
                    
                    Button(action: {self.addItem(itemName: title, itemDesc: description)}, label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    
                    
                }
                .padding([.bottom, .trailing])
                                
            })
            .navigationTitle("Todo List")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct listItemView: View {
    
    @State var item: ListItem
    
    var body: some View {
        
        HStack {
            //Toggle checkmark/xmark on item to keep track of completion
            Button(action: {self.item.completed = !self.item.completed}) {
                Image(systemName: item.splashImage)
                    .padding(.all)
            }
            
            VStack
            {
                Text(item.title)
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                Text(item.description)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
            }
            
            
        }
        
    }
}

struct itemizedListView: View {
    
    @Binding var itemsToDo: [ListItem]
    
    var body: some View {
        
        
        List {
            ForEach(itemsToDo) { item in
                //View for items goes here
                listItemView(item: item)
                Text(item.formattedDate)
                    .frame(height: 5.0)
            }
            .onDelete(perform: delete)
            //Swipe to delete list items when they are not relevant.
        }
        
        
    }
    
    //Delete list at current index
    func delete(at offsets: IndexSet)
    {
        itemsToDo.remove(atOffsets: offsets)
    }
}
