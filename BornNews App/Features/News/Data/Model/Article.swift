//
//  Article.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation
import UIKit

struct Source: Codable {
    let id: String?
    let name: String
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var imageData: Data?
    
    var publishedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter.date(from: self.publishedAt)
    }
}


// MARK: Populate
extension Article {
    static func getSample() -> Article {
        return
            Article(
                source: Source(id: nil, name: "Google News"), author: "Joel Khalili",
                title: "FTX Creditors Say Payout Deal Is 'an Insult'—and Plan to Revolt",
                description: "FTX has a plan to repay its former crypto customers more than the billions of dollars they lost in the latest bankruptcy proposal. But some will reject it anyway.",
                url: "https://www.wired.com/story/ftx-creditors-crypto-payout-rejection/",
                urlToImage: "https://media.wired.com/photos/663ba309e6755459097533ca/191:100/w_1280,c_limit/FTX-Bankruptcy-Business-GettyImages-1245052532.jpg",
                publishedAt: "2024-05-08T17:00:02Z",
                content: "Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem. Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem. Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem"
            )
    }
}
