//
//  MessageModel.swift
//  ChatTestapp


import Foundation

// MARK: - MessageModel
struct MessageModel: Codable {
    let data: [MessageData]
    let meta: Meta1
}

// MARK: - Datum
struct MessageData: Codable {
    let id, conversationID, sender, receiverType: String?
    let receiver, category, type: String?
    let data: DataClass1?
    let sentAt, updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case conversationID = "conversationId"
        case sender, receiverType, receiver, category, type, data, sentAt, updatedAt
    }
}

// MARK: - DataClass
struct DataClass1: Codable {
    let text: String?
    let entities: Entities1?
    let metadata: Metadata1?
}

// MARK: - Entities
struct Entities1: Codable {
    let sender, receiver: Receiver1?
}

// MARK: - Receiver
struct Receiver1: Codable {
    let entity: Entity1?
    let entityType: String?
}

// MARK: - Entity
struct Entity1: Codable {
    let uid, name, role: String?
    let avatar: String?
    let status: String?
    let createdAt: Int?
    let conversationID: String?
    let lastActiveAt: Int?

    enum CodingKeys: String, CodingKey {
        case uid, name, role, avatar, status, createdAt
        case conversationID = "conversationId"
        case lastActiveAt
    }
}

// MARK: - Metadata
struct Metadata1: Codable {
    let newKey: String?
}

// MARK: - Meta
struct Meta1: Codable {
    let current: Current?
    let next: Next?
}

// MARK: - Current
struct Current: Codable {
    let limit, count: Int?
}

// MARK: - Next
struct Next: Codable {
    let affix: String?
    let sentAt: Int?
    let id: String?
}

