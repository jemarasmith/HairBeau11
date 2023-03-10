//
//  SignUpView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Uh oh"
    @State private var isLinkActive = false
    
    
    func loadImage(){
        guard let inputImage = pickedImage else {return}
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || username.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
            return "Please complete all fields and select an image"
        }
        
        return nil
    }
    func clearFields() {
        self.email = ""
        self.username = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: {
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
        ScrollView{
            VStack(spacing: 20){
                Image(systemName: "heart.fill").font(.system(size: 60, weight: .black, design: .monospaced))
                
                VStack(alignment: .leading){
                    Text("Welcome 2 Hair Beau").font(.system(size: 32, weight: .heavy))
                    
                    Text("Sign Up 2 Start").font(.system(size: 16, weight: .medium))
                    
                }
                
                VStack{
                    if profileImage != nil {
                        profileImage!
                            .resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 200, height: 200)
                            .padding(.top, 20)
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .padding(.top, 20)
                            .foregroundColor(.pink)
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                    }
                }
            }
            Group{
                FormField(value: $username, icon: "person.fill", placeholder: "Username")
                FormField(value: $email, icon: "envelope.fill", placeholder: "E-Mail")
                FormField(value: $password, icon: "lock.fill", placeholder: "Password", isSecure: true)
            }
            NavigationLink(destination: SignInView(), isActive: $isLinkActive){
            Button(action: {signUp()
                self.isLinkActive = true
            }){
                Text("Sign Up").font(.title).modifier(ButtonModifiers())
            }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
                    }
                }
            HStack{
                Text("Got an account? Hit the back button to log in")
                
            }.padding()
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text(""), buttons: [.default(Text("Choose A Photo")){
                self.sourceType = .photoLibrary
                self.showingImagePicker = true
            },
                                                   .default(Text("Take A Photo")){
                                                       self.sourceType = .camera
                                                       self.showingImagePicker = true
                                                   },
                                                   .cancel()
                                                   
                                                  ])
        }
    }
}
                                                   
        struct SignUpView_Previews: PreviewProvider {
            static var previews: some View {
                SignUpView()
            }
        }
    

