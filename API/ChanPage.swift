import Foundation

struct ChanPage: CustomStringConvertible {
    var threads: [ChanThread]?

    public var description: String {
        var string = ""
        if let threads = self.threads {
            for thread in threads {
                if let post = thread.posts?.first {
                    string += "\u{001B}[34m\(post.no)\u{001B}[m : \u{001B}[33m\(post.sub ?? post.com ?? "")\n\u{001B}[36m\(post.replies ?? 0)\u{001B}[m replies, \u{001B}[32m\(post.images ?? 0)\u{001B}[m images\n\n"
                }
            }
        }
        return string
    }

    init(dictionary: [String: Any]) {
        self.threads = (dictionary["threads"] as? [[String: Any]])?.map { ChanThread(dictionary: $0) }
    }

    init?(data: Data) {
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else { return nil }
        self.init(dictionary: json)
    }

    init?(json: String) {
        self.init(data: Data(json.utf8))
    }
}
