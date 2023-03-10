//
//  SignInView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var session: SessionStore

   
    func listen() {
        session.listen()
    }
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Uh oh"
   
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "Please complete all fields"
        }
        
        return nil
    }
    
    func clearFields() {
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            (user) in
            self.clearFields()
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                Image(systemName: "heart.fill").font(.system(size: 60, weight: .black, design: .monospaced))
                
                VStack(alignment: .leading){
                    Text("Welcome 2 Hair Beau").font(.system(size: 32, weight: .heavy))
                    //                    .foregroundColor(.white)
                    Text("Sign In 2 Continue").font(.system(size: 16, weight: .medium))
                    //                    .foregroundColor(.white)
                }
                FormField(value: $email, icon: "envelope.fill", placeholder: "E-Mail")
                FormField(value: $password, icon: "lock.fill", placeholder: "Password", isSecure: true)
                
                Button(action: { signIn()
                listen()
                       }) {
                    Text("Sign In").font(.title).modifier(ButtonModifiers())
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
                }
                HStack{
                    Text("New?")
                    NavigationLink(destination: SignUpView()){
                        Text("Create an account").font(.system(size: 20, weight: .semibold))
                    }
                }
            }.padding()
        }
    }
    
    
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView()
        }
    }
}
