//
//  ApiClient.swift
//  KataAgendaIOS
//
//  Created by Alberto on 23/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import Foundation

class ApiClient {
    func sync(completion: @escaping (_ contacts:[Contact]) -> Void) {        
        DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 1) {
            var items = [Contact]()
            items.append(Contact(id: "1", name: "Alberto", username: "apeam", address: Address(postalCode: "15172", streetName: "Rúa Lucín, n8 bajo c"), company: Company(name: "Mobgen", phone: "000-00-00-00")))
            completion(items)
        }
    }
}
