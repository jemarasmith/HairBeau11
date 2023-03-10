//
//  ContentView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore

   
    func listen() {
        session.listen()
    }
    
    var body: some View {
        Group{
            if (session.session != nil) {
                HomeView()
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
    
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
