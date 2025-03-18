//
//  ProfileView.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 18/03/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text("ProfileView")
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("userName")
                Text("userEmail")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
