//
//  SearchBar.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/10/23.
//

import SwiftUI
import Foundation

struct SearchBar: View {
    @Binding var value: String
    @State var isSearching = false
    
    var body: some View {
        HStack{
            TextField("Search users here", text: $value)
                .padding(.leading, 24)
        }.padding()
            .background(Color(.systemPink))
            .cornerRadius(6.0)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    Button(action: {value = ""}) {
                        Image(systemName: "xmark.circle.fill")
                    }
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            )
        
    }
}


//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
