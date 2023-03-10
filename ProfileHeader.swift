//
//  ProfileHeader.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeader: View {
    // Variables
    var user: User?
    var postsCount: Int
    @Binding var following: Int
    @Binding var followers: Int
    
    var body: some View {
        HStack {
            VStack {
                if (user != nil) {
                    WebImage(url: URL(string: user!.profileImageUrl)!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                } else {
                    Color.init(red: 0.9, green: 0.9, blue: 0.9)
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                }
                
                if (self.user == nil) { Text("") }
                else {
                    Text(user!.username)
                        .font(.headline)
                        .bold()
                        .padding(.leading)
                }
            }
            
            VStack {
                HStack {
                    VStack {
                        Text("\(postsCount)")
                            .font(.title)
                            .bold()
                        Text("Posts")
                            .font(.footnote)
                            .bold()
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(self.followers)")
                            .font(.title)
                            .bold()
                        Text("Followers")
                            .font(.footnote)
                            .bold()
                        
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(self.following)")
                            .font(.title)
                            .bold()
                        Text("Following")
                            .font(.footnote)
                            .bold()
                        
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                }
            }
        }
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    @State(initialValue: 0) var followers: Int
    @State(initialValue: 0) var following: Int
    static var previews: some View {
        ProfileHeader(postsCount: 1, following: .constant(0), followers: .constant(0))
    }
}
