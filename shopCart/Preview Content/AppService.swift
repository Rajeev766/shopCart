//
//  AppService.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 17/03/25.
//

import Appwrite

enum RequestStatus{
    case success
    case error(_ message: String)
}
class AppService {
    let client = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("67d802560000b6e3d21b")
        .setSelfSigned(true)
    
    
    let account: Account
    
        init() {
            account = Account(client)
        }
    
    func createUser (email: String, password: String) async throws -> RequestStatus {
        do {
            _ = try await account.create(userId: ID.unique(), email: email, password: password)
            return .success
        }
        catch {
            return .error(error.localizedDescription)
        }
    }
    
    func login (email: String, password: String) async throws -> RequestStatus {
        do {
            _ = try await account.createEmailPasswordSession(email: email, password: password) //recheck the createemailsession
            return .success
        }
        catch {
            return .error(error.localizedDescription)
        }
    }
    
    func logout () async throws -> RequestStatus {
        do {
            _ = try await account.deleteSession(sessionId: "currentSession")
            return .success
        }
        catch {
            return .error(error.localizedDescription)
        }
    }
}

