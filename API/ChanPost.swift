import Foundation

struct ChanPost: CustomStringConvertible {
    let no: Int                 // Post number
    let resto: Int              // Reply to
    let now: String             // Date and time
    let time: Int               // UNIX timestamp
    let tim: Int                // Renamed filename (UNIX timestamp + milliseconds)

    /// Optionals
    let id: String?             // ID
    let name: String?           // Name
    let trip: String?           // Tripcode
    let sub: String?            // Subject
    let com: String?            // Comment
    let capcode: String?        // Capcode
    let country: String?        // Country code
    let country_name: String?   // Country name
    let last_modified: Int?     // Time when last modified

    /// Only displays on OPs
    let sticky: Bool?           // Stickied thread?
    let closed: Bool?           // Closed thread?
    let archived: Bool?         // Archived thread?
    let custom_spoiler: Int?    // Custom spoilers?
    let omitted_posts: Int?     // # replies omitted
    let omitted_images: Int?    // # image replies omitted
    let replies: Int?           // # replies total
    let images: Int?            // # images total
    let bumplimit: Bool?        // Bump limit met?
    let imagelimit: Bool?       // Image limit met?
    let semantic_url: String?   // Thread URL slug

    /// Only displays on OPs when archived is true
    let archived_on: Int?       // Time when archived

    /// Only displays on OPs when image uploaded
    let filename: String?       // Original filename
    let ext: String?            // File extension
    let fsize: Int?             // File size
    let md5: String?            // File MD5
    let w: Int?                 // Image width
    let h: Int?                 // Image height
    let tn_w: Int?              // Thumbnail width
    let tn_h: Int?              // Thumbnail height
    let filedeleted: Bool?      // File deleted?
    let spoiler: Bool?          // Spoiler image?

    /// Only displays on /f/
    let tag: String?            // Thread tag

    /// Only displays on /q/ when there are capcode user replies
    let capcode_replies: [String: [Int]]?   // array of capcode type and post IDs

    /// Only when 4chan Pass owner enters since4pass into Options field
    let since4pass: Int?        // Year 4chan Pass bought

    public var description: String {
        var string = "\u{001B}[34m\(self.no)\u{001B}[m"
        if let sub = self.sub {
            string += " - \u{001B}[33m"+sub+"\u{001B}[m"
        }
        if let com = self.com {
            string += " - "+flattenHTML(com)
        }
        if let file = self.filename, let ext = self.ext, let w = self.w, let h = self.h {
            string += " - (\u{001B}[36m"+file+ext+" \u{001B}[32m\(w)x\(h)\u{001B}[m)"
        }
        return string
    }

    init(dictionary: [String: Any]) {
        self.no = dictionary["no"] as? Int ?? 0
        self.resto = dictionary["resto"] as? Int ?? 0
        self.now = dictionary["now"] as? String ?? ""
        self.time = dictionary["time"] as? Int ?? 0
        self.tim = dictionary["tim"] as? Int ?? 0

        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.trip = dictionary["trip"] as? String
        self.sub = dictionary["sub"] as? String
        self.com = dictionary["com"] as? String
        self.capcode = dictionary["capcode"] as? String
        self.country = dictionary["country"] as? String
        self.country_name = dictionary["country_name"] as? String
        self.last_modified = dictionary["last_modified"] as? Int

        self.sticky = (dictionary["sticky"] as? NSNumber)?.boolValue
        self.closed = (dictionary["closed"] as? NSNumber)?.boolValue
        self.archived = (dictionary["archived"] as? NSNumber)?.boolValue
        self.custom_spoiler = dictionary["custom_spoiler"] as? Int
        self.omitted_posts = dictionary["omitted_posts"] as? Int
        self.omitted_images = dictionary["omitted_images"] as? Int
        self.replies = dictionary["replies"] as? Int
        self.images = dictionary["images"] as? Int
        self.bumplimit = (dictionary["bumplimit"] as? NSNumber)?.boolValue
        self.imagelimit = (dictionary["imagelimit"] as? NSNumber)?.boolValue
        self.semantic_url = dictionary["semantic_url"] as? String

        self.archived_on = dictionary["archived_on"] as? Int

        self.filename = dictionary["filename"] as? String
        self.ext = dictionary["ext"] as? String
        self.fsize = dictionary["fsize"] as? Int
        self.md5 = dictionary["md5"] as? String
        self.w = dictionary["w"] as? Int
        self.h = dictionary["h"] as? Int
        self.tn_w = dictionary["tn_w"] as? Int
        self.tn_h = dictionary["tn_h"] as? Int
        self.filedeleted = (dictionary["filedeleted"] as? NSNumber)?.boolValue
        self.spoiler = (dictionary["spoiler"] as? NSNumber)?.boolValue

        self.tag = dictionary["tag"] as? String

        self.capcode_replies = dictionary["capcode_replies"] as? [String: [Int]]

        self.since4pass = dictionary["since4pass"] as? Int
    }

    init?(data: Data) {
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else { return nil }
        self.init(dictionary: json)
    }

    init?(json: String) {
        self.init(data: Data(json.utf8))
    }

    private func flattenHTML(_ html: String) -> String {
        let flat = html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        if #available(macOS 10.3, *) {
            return CFXMLCreateStringByUnescapingEntities(nil, flat as CFString, nil) as String
        }
        return flat
    }
}
