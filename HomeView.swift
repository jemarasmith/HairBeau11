//
//  HomeView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
        
        var body: some View {
            
            NavigationView {
                
                TabView {
                    
                    MainView()
                        .tabItem {
                            Image(systemName: "house.fill")
                        }
                    
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }
                    
                    ShoppingView()
                        .tabItem {
                            Image(systemName: "cart.fill")
                        }
                    MapView()
                        .tabItem {
                            Image(systemName: "globe")
                        }
                    
                    PostView()
                        .tabItem {
                            Image(systemName: "camera.fill")
                        }
                    
                    NotificationsView()
                        .tabItem {
                            Image(systemName: "heart.fill")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                        }
                }.accentColor(.pink)
                .navigationTitle("Hair Beau")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: logoutButton)
                .accentColor(.black)
            }
        }
    }

    extension HomeView {
        
        var logoutButton: some View {
            
            Button  {
                //AuthenticationViewModel.shared.signout()
            } label: {
                Text("Logout").foregroundColor(.pink)
            }
        }
        
    }
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
