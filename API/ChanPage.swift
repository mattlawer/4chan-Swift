import Foundation

struct ChanPage: CustomStringConvertible {
    var threads: [ChanThread]?

    public var description: String {
        var string = ""
        if let threads = self.threads {
            for thread in threads {
                string += thread.description+"\n"
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
