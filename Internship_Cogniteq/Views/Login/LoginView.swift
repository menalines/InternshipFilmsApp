//
//  LoginView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 30.03.21.
//

import Foundation
import SwiftUI

//Valid username and password
private let storedUsername = "user"
private let storedPassword = "pass"

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var authenticationDidFail: Bool = false
    @ObservedObject var state: LoginState
    
    var disabledButton: Bool {
        !(username.count > 3 && password.count > 3)
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Login")
                UsernameTextField(username: $username)
                Text("Password")
                PasswordSecureField(password: $password)
            }.padding()
            
            Button(action: {
                if self.username == storedUsername, self.password == storedPassword {
                    state.controller?.openMainView()
                    self.authenticationDidFail = false
                } else {
                    self.authenticationDidFail = true
                }
            }) {
                Text("Sign In")
                    .foregroundColor(disabledButton ? .black : .blue)
            }
            .disabled(disabledButton)
            
            if authenticationDidFail {
                Text("Information not correct.\nLogin: user\nPassword: pass")
                    .offset(y: 10)
                    .foregroundColor(.red)
            }
        }
    }
}

final class LoginState: ObservableObject {
    var controller: LoginViewProtocol?
}

struct UsernameTextField : View {
    @Binding var username: String
    
    var body: some View {
        return TextField("Username", text: $username)
            .autocapitalization(.none)
            .padding(10)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
    }
}

struct PasswordSecureField : View {
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .padding(10)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
    }
}
