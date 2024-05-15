//
//  Article.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation
import UIKit


struct ArticleModel: Codable {
    var source: SourceModel
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var imageData: Data?
    
    init(source: SourceModel, author: String? = nil, title: String, description: String? = nil, url: String, urlToImage: String? = nil, publishedAt: String, content: String? = nil, imageData: Data? = nil) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.imageData = imageData
    }
}

extension ArticleModel: Article {
    
    var sourceName: String {
        self.source.name
    }
    
    var authorName: String {
        self.author ?? "Unknown author"
    }
    
    var summary: String {
        self.description ?? "Check out the link to know more about ir"
    }
    
    var publishedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter.date(from: self.publishedAt)
    }
}


// MARK: Populate
extension ArticleModel {
    static func getSample() -> ArticleModel {
        return
            ArticleModel(
                source: SourceModel(id: nil, name: "Google News"), author: "Joel Khalili",
                title: "FTX Creditors Say Payout Deal Is 'an Insult'—and Plan to Revolt",
                description: "FTX has a plan to repay its former crypto customers more than the billions of dollars they lost in the latest bankruptcy proposal. But some will reject it anyway.",
                url: "https://www.wired.com/story/ftx-creditors-crypto-payout-rejection/",
                urlToImage: "https://media.wired.com/photos/663ba309e6755459097533ca/191:100/w_1280,c_limit/FTX-Bankruptcy-Business-GettyImages-1245052532.jpg",
                publishedAt: "2024-05-08T17:00:02Z",
                content: "Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem. Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem. Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem"
            )
    }
}
