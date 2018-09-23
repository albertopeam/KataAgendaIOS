//
//  Agenda.swift
//  KataAgendaIOS
//
//  Created by Alberto on 21/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import Foundation

class Agenda {
    
    private let defaults:UserDefaults
    private let apiClient:ApiClient
    
    init(defaults:UserDefaults = UserDefaults(), apiClient:ApiClient = ApiClient()) {
        self.defaults = defaults
        self.apiClient = apiClient
    }
    
    func add(contact: Contact) -> Contact {
        defaults.set(try? PropertyListEncoder().encode(contact), forKey:"contact:\(contact.id)")
        defaults.synchronize()
        return contact
    }
    
    func getById(id: String) -> Contact? {
        return map(id: "contact:\(id)")
    }
    
    func getAll() -> [Contact] {
        let keys = defaults.dictionaryRepresentation().keys
        var contacts = [Contact]()
        for key in keys {
            if key.contains("contact:"){
                let contact = map(id: key)
                contacts.append(contact!)
            }
        }
        return contacts
    }
    
    func deleteAll() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
    
    func getNumberOfContactsWithNameWithTheLetterP() -> Int {
        let items = getAll().filter { (contact) -> Bool in
            return contact.name.contains("p") || contact.name.contains("P")
        }
        return items.count
    }
    
    //spec: sync backend, remove local & replace
    //mock: meter api client mock
    func sync(){
        apiClient.sync { contacts in
            self.deleteAll()
            contacts.forEach({ (contact) in
                _ = self.add(contact: contact)
            })
        }
    }
    
    private func map(id:String) -> Contact? {
        if let data = defaults.value(forKey:id) as? Data {
            let contact = try? PropertyListDecoder().decode(Contact.self, from: data)
            return contact!
        }
        return nil
    }
}

struct Contact:Codable, Equatable {
    let id:String
    let name:String
    let username:String
    let address:Address
    let company:Company?
}

struct Address:Codable, Equatable {
    let postalCode:String
    let streetName:String
}

struct Company:Codable, Equatable {
    let name:String
    let phone:String
}
