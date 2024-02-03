//
//  SendMessageModel.swift

import Foundation

// MARK: - SendMessageModel
struct SendMessageModel: Codable {
    let category, type: String
    let data: SendMessageData
    let receiver, receiverType: String
}

// MARK: - DataClass
struct SendMessageData: Codable {
    let text: String
}

