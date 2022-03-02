//
//  GithubUserModel.swift
//  BasicNetwork
//
//  Created by MAXIM ZHELEZNYY on 01.03.2022.
//

import Foundation

struct GithubUserModel: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String?
    let profileUrl: String
    let name: String?
    let bio: String?
    let email: String?

    enum CodingKeys: String, CodingKey {
        case login, id, name, bio, email
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case profileUrl = "html_url"
    }
}
