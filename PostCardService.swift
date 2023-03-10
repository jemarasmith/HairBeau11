//
//  PostCardService.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService : ObservableObject {
    @Published var post: PostModel!
    @Published var isLiked = false
    
    func hasLickedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        PostService.getPostsUserId(userId: post.ownerId).collection("Posts").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.allPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.getTimelineUserId(userId: post.ownerId).collection("Timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.getPostsUserId(userId: post.ownerId).collection("Posts").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.allPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.getTimelineUserId(userId: post.ownerId).collection("Timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
}

