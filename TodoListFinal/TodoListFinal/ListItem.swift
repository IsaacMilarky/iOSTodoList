//
//  ListItem.swift
//  TodoListFinal
//
//  Created by imfbp on 5/6/21.
//

import Foundation

struct ListItem: Identifiable
{
    var id = UUID()
    var title: String
    var description: String
    
    var dateCreated: Date
    
    var completed: Bool = false
    
    var splashImage: String {
        if(completed)
        {
            return "checkmark"
        }
        else
        {
            return "xmark"
        }
    }
    
    
    var formattedDate: String {
        //Calculated date formatter for ez convert
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YY/MM/dd"
        
        return dateFormatter.string(from: dateCreated)
    }
}
