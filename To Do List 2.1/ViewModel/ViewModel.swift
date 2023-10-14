//
//  ViewModel.swift
//  To Do List 2.1
//
//  Created by Vlad Klunduk on 14/10/2023.
//

import Foundation
import UIKit
import CoreData

class ViewModel {
    
    var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func getItems() -> [Item] {
        guard let items = try? context.fetch(Item.fetchRequest()) else { return [] }
        return items
    }
    
    func createItem(_ name: String){
        let newItem = Item(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        appDelegate.saveContext()
    }
    
    func deleteItem(_ item: Item){
        context.delete(item)
        appDelegate.saveContext()
    }
    
    func updateItem(_ item: Item, newName: String){
        item.name = newName
        appDelegate.saveContext()
    }
}
