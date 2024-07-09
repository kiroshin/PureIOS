//
//  HTTPRandomuserAccess.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation

struct HTTPRandomuserAccess: HTTPGetting {
    private let base: URL = URL(string: "https://randomuser.me/api/")!
    
    func getAllUser(_ count: Int, retry: Int) async throws -> [User] { do {
        let url = base.appending(queryItems: [.init(name: "results", value: "\(count)")])
        let (raw, _) = try await getJson(detype: Users.self, url: url)
        return raw.results
    } catch where 0 < retry {
        try? await Task.mxSleep(sec: 2)
        return try await getAllUser(count, retry: retry - 1)
    } catch {
        throw error
    } }
    
    struct Users: Codable {
        let results: [User]
    }
    
    struct User: Codable {
        let gender: String?
        let name: Name
        let email: String?
        let login: Login
        let dob: Dob
        let cell: String?
        let picture: Picture
        let nat: String?
    }
    
    struct Name: Codable {
        let first, last: String?
    }
    
    struct Login: Codable {
        let uuid, username: String?
    }
    
    struct Dob: Codable {
        let date: String
        let age: Int?
    }
    
    struct Picture: Codable {
        let large: String?
    }
    
}

