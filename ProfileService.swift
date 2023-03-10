//
//  ProfileService.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import Foundation
import Firebase

class ProfileService: ObservableObject {
    
    @Published var posts: [PostModel] = []
    @Published var following = 0
    @Published var followers = 0
    
    static var following = AuthService.storeRoot.collection("Following")
    static var followers = AuthService.storeRoot.collection("Followers")
    
    /// Get the following collection by Id
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("Following")
    }
    
    /// Get the followewers collection by id
    static func followerCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("Followers")
    }
    
    /// Load the users' posts
    func loadUserPosts(userId: String) {
        PostService.loadUserPosts(userId: userId) {
            (posts) in
            
            self.posts = posts
        }
        
        follows(userId: userId)
        follower(userId: userId)
    }
    
    func follows(userId: String) {
        ProfileService.followingCollection(userId: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.following = doc.count
            }
        }
    }
    
    func follower(userId: String) {
        ProfileService.followerCollection(userId: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.followers = doc.count
            }
        }
    }
}

