//
//  CustonCameraView.swift
//  testCamera
//
//  Created by Gabriel Caldeira on 02/12/22.
//

import SwiftUI

struct CustonCameraView: View {
    
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack{
            
            CameraView(cameraService: cameraService, didFinishProcessingPhoto: { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        capturedImage = UIImage(data: data)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Error: No image Data found")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
            VStack{
                Spacer()
                Button(action: {
                    cameraService.caputurePhot()
                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                })
                .padding(.bottom)
                
            }
        }
    }
}
