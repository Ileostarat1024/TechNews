//
//  PostData.swift
//  TechNews
//
//  Created by Yi-Ting Lu on 2024/9/17.
//

import Foundation

struct Results: Decodable {
    var articles: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return source.name
    }
    struct Source: Decodable {
        let name: String
    }
    let source: Source
    let title: String
    let url: String
    let urlToImage: String?
    var publishedAt: String
}
