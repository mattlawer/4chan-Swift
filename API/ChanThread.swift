import Foundation

struct ChanThread: CustomStringConvertible {
    var posts: [ChanPost]?

    public var description: String {
        var string = ""
        if let posts = self.posts {
            for post in posts {
                string += post.description+"\n"
            }
        }
        return string
    }

    init(dictionary: [String: Any]) {
        self.posts = (dictionary["posts"] as? [[String: Any]])?.map { ChanPost(dictionary: $0) }
    }

    init?(data: Data) {
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else { return nil }
        self.init(dictionary: json)
    }

    init?(json: String) {
        self.init(data: Data(json.utf8))
    }
}
