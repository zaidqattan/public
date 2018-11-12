//
//  JSONModel.swift
//  iOSTask
//
//  Created by Zaid Qattan on 11/9/18.
//  Copyright © 2018 Elsuhud. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let content: [Content]?
    let last: Bool?
    let totalPages: Int?
    let totalElements: Int?
    let sort: String?
    let numberOfElements: Int?
    let first: Bool?
    let size: Int?
    let number: Int?
    
//    init(content: [Content]? = nil,
//        last: Bool? = nil,
//        totalPages: Int? = nil,
//        totalElements: Int? = nil,
//        sort: String? = nil,
//        numberOfElements: Int? = nil,
//        first: Bool? = nil,
//        size: Int? = nil,
//        number: Int? = nil
//        )
//    {
//        self.content = content
//        self.last = last
//        self.totalPages = totalPages
//        self.totalElements = totalElements
//        self.sort = sort
//        self.numberOfElements = numberOfElements
//        self.first = first
//        self.size = size
//        self.number = number
//    }
}

struct Content: Decodable {
    let id: Int?
    let name: String?
    let ipAddress: String?
    let ipSubnetMask: String?
    let model: Model?
    let locationId: Int?
    let status: Status?
    let type: Type?
    let serialNumber: String?
    let version: String?
    let communicationProtocols: [CommunicationProtocols]?
    let targetMachines: [TargetMachines]?
    let location: Int?
    let serialNum: String?
}

struct Model: Decodable {
    let id: Int?
    let name: String?
    let creationDate: String?
    let expiryDate: String?
}

struct Status: Decodable {
    let id: Int?
    let statusValue: String?
    let legacyValue: String?
}

struct Type: Decodable {
    let id: Int?
    let name: String?
}
struct CommunicationProtocols: Decodable {
    let id: Int?
    let name: String?
    let defaultPort: Int?
}

struct TargetMachines: Decodable {
    let id: Int?
    let sourceMachineId: Int?
    let targetMachine: TargetMachine?
    let circuitStatusId: Int?
}

struct TargetMachine: Decodable {
    let id: Int?
    let name: String?
    let ipAddress: String?
    let ipSubnetMask: String?
    let model: Model?
    let locationId: Int?
    let status: Status?
    let type: Type?
    let serialNumber: String?
    let version: String?
    let communicationProtocols: [CommunicationProtocols]?
    let targetMachines: [TargetMachines]?
    let location: Int?
    let serialNum: String?
}

