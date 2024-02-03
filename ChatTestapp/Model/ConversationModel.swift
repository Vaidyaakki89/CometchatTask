//
//  ConversationModel.swift
//  ChatTestapp
//
//  Created by AKSHAY VAIDYA on 02/02/24.
//

import Foundation

// MARK: - ConversationModel
struct ConversationModel: Codable {
    let data: [ConversationData]
    let meta: Meta
}

// MARK: - Datum
struct ConversationData: Codable {
    let conversationID, conversationType, unreadMessageCount: String?
    let createdAt, updatedAt: Int?
    let lastMessage: LastMessage?
    let lastReadMessageID: String?
    let conversationWith: ConversationWith?

    enum CodingKeys: String, CodingKey {
        case conversationID = "conversationId"
        case conversationType, unreadMessageCount, createdAt, updatedAt, lastMessage
        case lastReadMessageID = "lastReadMessageId"
        case conversationWith
    }
}

// MARK: - ConversationWith
struct ConversationWith: Codable {
    let uid: String?
    let name: String?
    let avatar: String?
    let status, role: String?
    let createdAt: Int?
    let conversationID: String?
    let guid: String?
    let icon: String?
    let type, scope: String?
    let joinedAt: Int?
    let hasJoined: Bool?
    let owner: String?
    let onlineMembersCount: Int?

    enum CodingKeys: String, CodingKey {
        case uid, name, avatar, status, role, createdAt
        case conversationID = "conversationId"
        case guid, icon, type, scope, joinedAt, hasJoined, owner, onlineMembersCount
    }
}

// MARK: - LastMessage
struct LastMessage: Codable {
    let id, conversationID, sender, receiverType: String?
    let receiver, category, type: String?
    let data: DataClass?
    let sentAt, updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case conversationID = "conversationId"
        case sender, receiverType, receiver, category, type, data, sentAt, updatedAt
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let text: String?
    let entities: Entities?
    let metadata: Metadata?
}

// MARK: - Entities
struct Entities: Codable {
    let sender, receiver: Receiver?
}

// MARK: - Receiver
struct Receiver: Codable {
    let entity: Entity?
    let entityType: String?
}

// MARK: - Entity
struct Entity: Codable {
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
struct Metadata: Codable {
    let newKey: String?
}

// MARK: - Meta
struct Meta: Codable {
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, count, perPage, currentPage: Int?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}
