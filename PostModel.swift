//
//  PostModel.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import Foundation

struct PostModel: Encodable, Decodable {
    
    var caption: String
    var likes: [String: Bool]
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
}
