//
//  Article.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}


// MARK: Populete
extension Article {
    static func getSampleArticles() -> [Article] {
        return [
            Article(
                author: "John Doe",
                title: "Sample Article 1",
                description: "This is a sample article description 1.",
                url: "https://example.com/sample-article-1",
                urlToImage: "https://example.com/sample-image-1.jpg",
                publishedAt: "2024-05-11T12:00:00Z",
                content: "This is the content of the sample article 1. It contains some example text."
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
