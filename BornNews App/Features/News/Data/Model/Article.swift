//
//  Article.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation
import UIKit

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var imageData: Data?
    
}


// MARK: Populate
extension Article {
    static func getSampleArticles() -> [Article] {
        return [
            Article(
                author: "Joel Khalili",
                title: "FTX Creditors Say Payout Deal Is 'an Insult'—and Plan to Revolt",
                description: "FTX has a plan to repay its former crypto customers more than the billions of dollars they lost in the latest bankruptcy proposal. But some will reject it anyway.",
                url: "https://www.wired.com/story/ftx-creditors-crypto-payout-rejection/",
                urlToImage: "https://media.wired.com/photos/663ba309e6755459097533ca/191:100/w_1280,c_limit/FTX-Bankruptcy-Business-GettyImages-1245052532.jpg",
                publishedAt: "2024-05-08T17:00:02Z",
                content: "Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem. Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem. Some creditors of the bankrupt crypto exchange FTX are preparing to reject a plan that would see them recover 118 percent of the money they lost. The proposal is far less generous than it might seem"
            ),
            Article(
                author: "Jane Smith",
                title: "Sample Article 2",
                description: "This is a sample article description 2.",
                url: "https://example.com/sample-article-2",
                urlToImage: "https://example.com/sample-image-2.jpg",
                publishedAt: "2024-05-10T10:30:00Z",
                content: "This is the content of the sample article 2. It contains some example text."
            ),
            Article(
                author: "Michael Johnson",
                title: "Sample Article 3",
                description: "This is a sample article description 3.",
                url: "https://example.com/sample-article-3",
                urlToImage: "https://example.com/sample-image-3.jpg",
                publishedAt: "2024-05-09T14:45:00Z",
                content: "This is the content of the sample article 3. It contains some example text."
            ),
            Article(
                author: "Emily Williams",
                title: "Sample Article 4",
                description: "This is a sample article description 4.",
                url: "https://example.com/sample-article-4",
                urlToImage: "https://example.com/sample-image-4.jpg",
                publishedAt: "2024-05-08T08:20:00Z",
                content: "This is the content of the sample article 4. It contains some example text."
            ),
            Article(
                author: "Chris Anderson",
                title: "Sample Article 5",
                description: "This is a sample article description 5.",
                url: "https://example.com/sample-article-5",
                urlToImage: "https://example.com/sample-image-5.jpg",
                publishedAt: "2024-05-07T16:10:00Z",
                content: "This is the content of the sample article 5. It contains some example text."
            ),
            Article(
                author: "Jessica Brown",
                title: "Sample Article 6",
                description: "This is a sample article description 6.",
                url: "https://example.com/sample-article-6",
                urlToImage: "https://example.com/sample-image-6.jpg",
                publishedAt: "2024-05-06T09:00:00Z",
                content: "This is the content of the sample article 6. It contains some example text."
            ),
            Article(
                author: "David Taylor",
                title: "Sample Article 7",
                description: "This is a sample article description 7.",
                url: "https://example.com/sample-article-7",
                urlToImage: "https://example.com/sample-image-7.jpg",
                publishedAt: "2024-05-05T11:55:00Z",
                content: "This is the content of the sample article 7. It contains some example text."
            ),
            Article(
                author: "Sarah Martinez",
                title: "Sample Article 8",
                description: "This is a sample article description 8.",
                url: "https://example.com/sample-article-8",
                urlToImage: "https://example.com/sample-image-8.jpg",
                publishedAt: "2024-05-04T13:40:00Z",
                content: "This is the content of the sample article 8. It contains some example text."
            ),
            Article(
                author: "Daniel Clark",
                title: "Sample Article 9",
                description: "This is a sample article description 9.",
                url: "https://example.com/sample-article-9",
                urlToImage: "https://example.com/sample-image-9.jpg",
                publishedAt: "2024-05-03T15:25:00Z",
                content: "This is the content of the sample article 9. It contains some example text."
            ),
            Article(
                author: "Sophia Lee",
                title: "Sample Article 10",
                description: "This is a sample article description 10.",
                url: "https://example.com/sample-article-10",
                urlToImage: "https://example.com/sample-image-10.jpg",
                publishedAt: "2024-05-02T17:15:00Z",
                content: "This is the content of the sample article 10. It contains some example text."
            )
        ]
    }
}
