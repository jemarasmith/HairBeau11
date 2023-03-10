//
//  MainView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//


import SwiftUI
import FirebaseAuth

struct MainView: View {
//    var body: some View {
//        Text ("Main")
//    }
//}
//
    
    
    @EnvironmentObject var session: SessionStore
    @StateObject var profileService = ProfileService()

    var body: some View {
        if (self.session.session != nil) {
            ScrollView {
                VStack {
                    ForEach(self.profileService.posts, id:\.postId) {
                        (post) in
                        PostCardImage(post: post)

                        PostCard(post: post)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear {

                self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)

            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
