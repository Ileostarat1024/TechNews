//
//  DetailsView.swift
//  TechNews
//
//  Created by Yi-Ting Lu on 2024/9/17.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

#Preview {
    DetailView(url: "https://www.google.com")
}

