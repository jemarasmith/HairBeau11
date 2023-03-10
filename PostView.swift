//
//  PostView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI

struct PostView: View {
@State private var postImage: Image!
    @State private var pickedImage: Image!
    @State private var showImgActionSheet =  false
    @State private var showingImagePicker =  false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Uh oh "
    @State private var postText = ""
    
    var body: some View {
        VStack {
            Text("Upload A Post")
                .font(.largeTitle)
            
            VStack {
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: 300, height: 200)
                        .onTapGesture {
                            self.showImgActionSheet = true
                        }
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .frame(width: 250, height: 200)
                        .onTapGesture {
                            self.showImgActionSheet = true
                        }
                }
            }
            
            
            TextEditor(text: $postText)
                .frame(height: 200)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding(.horizontal)
            
            
            Button(action: uploadPost) {
                Text("Upload Post")
                    .font(.title)
                    .modifier(ButtonModifiers())
            }
            .padding(.top, 10)
            .padding(.horizontal)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
            }
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }.actionSheet(isPresented: $showImgActionSheet) {
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
    
    /// Load Post Image
    func loadImage() {
        guard let inputImage = pickedImage else {  return }
        
        postImage = inputImage
    }
    
    
    /// Validate that fields are completed
    func errorCheck() -> String? {
        if postText.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
            return "Please add a caption and select an image"
        }
        
        return nil
    }
    
    /**
     Clear Fields
     */
    func clearFields() {
        self.postText = ""
        self.imageData = Data()
        self.postImage = Image(systemName: "photo.fill")
    }
    
    /// Upload the post
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        PostService.uploadPost(caption: postText, imageData: imageData, onSuccess: {
            self.clearFields()
        }) {
            (errorMessage) in
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
}



struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
