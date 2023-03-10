//
//  UserModel.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import Foundation

struct User: Encodable, Decodable{
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var searchName: [String]
    var bio: String
    
    
}


//struct UserModel_Previews: PreviewProvider {
//    static var previews: some View {
//        UserModel()
//    }
//}
