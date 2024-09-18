//
//  TimeFormatter.swift
//  TechNews
//
//  Created by Yi-Ting Lu on 2024/9/17.
//

import Foundation

struct FormattedDate {
    let publishedAt: String
    
    // 創建一個 DateFormatter 來解析 ISO8601 標準的日期字串
    func formatDate() -> String{
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // 將字串轉換為 Date
        if let date = isoDateFormatter.date(from: publishedAt) {
            
            // 創建另一個 DateFormatter 來輸出所需格式
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "en_US")
            outputFormatter.dateStyle = .short // 使用長日期格式
            outputFormatter.timeStyle = .short // 短時間格式
//            outputFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
            
            // 將 Date 格式化為目標字串
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        } else {
            print("日期格式無法解析")
            return ""
        }
    }
}




