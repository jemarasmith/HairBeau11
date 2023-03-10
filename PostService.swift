//
//  PostService.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class PostService {
    // Variables
    static var posts = AuthService.storeRoot.collection("Posts")
    static var allPosts = AuthService.storeRoot.collection("allPosts")
    static var timeline = AuthService.storeRoot.collection("timeline")
    
    /// Get the post by user
    static func getPostsUserId(userId: String) -> DocumentReference {
        return posts.document(userId)
    }
    
    /// Get the time line user
    static func getTimelineUserId(userId: String) -> DocumentReference {
        return timeline.document(userId)
    }
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = getPostsUserId(userId: userId).collection("Posts").document().documentID
        
        let storagePostRef = StorageService.getStoragePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metaData: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
    
    static func loadUserPosts(userId: String, onSuccess: @escaping (_ posts: [PostModel]) -> Void) {
        
        PostService.getPostsUserId(userId: userId).collection("posts").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [PostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? PostModel.init(fromDictionary: dict)
                else {
                    return
                }
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
    
    
}

