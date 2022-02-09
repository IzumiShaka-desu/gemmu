//
//  AboutPageView.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
import SwiftUI
import NetworkImage

struct AboutPageView: View {
    
    var body: some View {
        NavigationView{
            VStack(){
                Spacer()
                NetworkImage(url: URL(string: Constants.profileImageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                } fallback: {
                    Image(systemName: "photo")                     }
                .frame(width: 150, height: 150)
                .clipped()
                .background().cornerRadius(10)
                Text(Constants.profileName)
                Text(Constants.positionName)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }.navigationTitle("About").navigationBarTitleDisplayMode(.inline).toolbar{
            }
        }.padding(0)
        
    }
}

struct AboutPageView_Previews: PreviewProvider {
    static var previews: some View {
        AboutPageView()
    }
}
