import SwiftUI
import SwiftUIBackports

import Demo

@Demo
struct FocusStateDemo {
    enum Field: Hashable {
        case username
        case password
    }

    @State private var username = ""
    @State private var password = ""
    @Backport.FocusState private var focusedField: Field?

    var body: some View {
        List {
            TextField("Username", text: $username)
                .backport.focused($focusedField, equals: .username)
                .backport.submitLabel(.next)
                .backport.onSubmit {
                    focusedField = .password
                }

            SecureField("Password", text: $password)
                .backport.focused($focusedField, equals: .password)
                .backport.submitLabel(.done)
                .backport.onSubmit {
                    signIn()
                }

            Button("Sign In") {
                signIn()
            }
        }
        .onAppear {
            focusedField = .username
        }
    }

    private func signIn() {
        if username.isEmpty {
            focusedField = .username
        } else if password.isEmpty {
            focusedField = .password
        } else {
            focusedField = nil
            print(username, password)
        }
    }
}
