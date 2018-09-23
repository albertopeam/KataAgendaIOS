//
//  KataAgendaIOSTests.swift
//  KataAgendaIOSTests
//
//  Created by Alberto on 21/9/18.
//  Copyright © 2018 com.github.albertopeam. All rights reserved.
//

import XCTest
@testable import KataAgendaIOS

class AgendaTests: XCTestCase {
    
    private var sut:Agenda!
    private var ID = "1"
    
    override func setUp() {
        super.setUp()
        sut = Agenda()
        sut.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
        sut.deleteAll()
        sut = nil
    }
    
    //MARK: Add
    
    func test_given_contact_when_add_then_stored() {
        let target = defaultContactWithCompany()
        let result = sut.add(contact: target)
        let found = sut.getById(id: ID)
        XCTAssertEqual(target, result)
        XCTAssertEqual(target, found)
    }

    // MARK: GetById
    
    func test_given_not_found_id_when_getbyid_then_return_nil() {
        let contact = sut.getById(id: ID)
        XCTAssertNil(contact)
    }
    
    func test_given_valid_id_when_getbyid_then_return_contact() {
        let target = defaultContactWithCompany()
        givenOneContact(contact: target)
        let contact = sut.getById(id: ID)
        XCTAssertEqual(target, contact)
    }
    
    // MARK: GetAll
    
    func test_given_empty_contacts_when_getall_then_return_empty() {
        let items = sut.getAll()
        XCTAssertEqual(items.count, 0)
    }
    
    func test_given_one_contacts_when_getall_then_return_one() {
        let target = defaultContactWithCompany()
        _ = sut.add(contact: target)
        let items = sut.getAll()
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(target, items[0])
    }
    
    // MARK: Number of contacts with P in their name
    
    func test_given_three_contacts_and_two_with_p_when_get_then_return_two() {
        let ids = ["5", "10"]
        for id in ids {
            let target = contactWithNameWithP(id: id)
            _ = sut.add(contact: target)
        }
        _ = sut.add(contact: defaultContactWithCompany())
        let count = sut.getNumberOfContactsWithNameWithTheLetterP()
        XCTAssertEqual(count, 2)
    }
    
    func test_given_one_contacts_without_p_when_get_then_return_zero() {
        let target = defaultContactWithCompany()
        _ = sut.add(contact: target)
        let count = sut.getNumberOfContactsWithNameWithTheLetterP()
        XCTAssertEqual(count, 0)
    }
    
    // MARK: Private
    
    private func givenOneContact(contact:Contact) {
        _ = sut.add(contact: contact)
    }
    
    private func defaultContactWithCompany() -> Contact {
        return Contact(id: ID, name: "name", username: "username", address: Address(postalCode: "postalCode", streetName: "streetName"), company: Company(name: "name", phone: "phone"))
    }
    
    private func contactWithNameWithP() -> Contact {
        return Contact(id: ID, name: "paquito", username: "username", address: Address(postalCode: "postalCode", streetName: "streetName"), company: Company(name: "name", phone: "phone"))
    }
    
    private func contactWithNameWithP(id:String) -> Contact {
        return Contact(id: id, name: "paquito", username: "username", address: Address(postalCode: "postalCode", streetName: "streetName"), company: Company(name: "name", phone: "phone"))
    }
    
    private func defaultContactWithId(id:String) -> Contact {
        return Contact(id: id, name: "name", username: "username", address: Address(postalCode: "postalCode", streetName: "streetName"), company: Company(name: "name", phone: "phone"))
    }
}
