//
//  ContentView.swift
//  TechNews
//
//  Created by Yi-Ting Lu on 2024/9/17.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    init() {
            // 處理導覽欄
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            // 設置導航欄的背景顏色
        appearance.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            // 設置標題的顏色
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            // 設置大標題的顏色
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some View {
        NavigationStack{
            ZStack{
                // 背景顏色
                Color.init(red: 0.1, green: 0.1, blue: 0.1)
                    .ignoresSafeArea()
                List(networkManager.posts){ post in
                    NavigationLink(destination: DetailView(url:post.url)) {
                        VStack{
                            HStack{
                                if let imgeURL = post.urlToImage {
                                    AsyncImage(url: URL(string: imgeURL)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        // 當圖片下載時顯示一個進度指示器
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 100)
                                    // 強行裁切成 100x100
                                    .clipped()
                                } else {
                                    // 若原檔沒圖片時用問號替代
                                    Image("FailedToLoad")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                }
                                
                                Text(post.title)
                                    .padding(.leading, 8)
                                 
                                Spacer()
                            }
                            HStack{
                                Text(post.publishedAt)
                                    .foregroundStyle(Color.gray)
                                    .font(.system(size: 12))
                                Spacer()
                            }
                        }
                    }
                } // 隱藏 List 原本的背景
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("每日科技新聞")
            
        }
        // viewDidLoad
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
