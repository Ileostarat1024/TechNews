//
//  NetworkManager.swift
//  TechNews
//
//  Created by Yi-Ting Lu on 2024/9/17.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?category=technology&apiKey=\(K.apiKey)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            // 創建一個新的陣列，用來存放格式化日期後的文章
                            var formattedArticles = [Post]()
                            // 遍歷每篇文章並格式化其發布日期
                            for var post in results.articles {
                                let formattedDate = FormattedDate(publishedAt: post.publishedAt).formatDate()
                                post.publishedAt = formattedDate // 更新文章的發布日期
                                formattedArticles.append(post) // 將更新後的文章加入新陣列
                            }
                            DispatchQueue.main.async{
                                self.posts = formattedArticles
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
