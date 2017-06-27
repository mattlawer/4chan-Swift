import Foundation

extension URLSession {

    private static let chanAPIRoot = "https://a.4cdn.org"

    func chanTask(_ board: String, page: Int, completionHandler: @escaping (ChanPage?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        let url = URL(string: String(format: URLSession.chanAPIRoot+"/%@/%d.json", board, page))!
        return self.dataTask(with: URLRequest(url: url), completionHandler: { (data, response, error) in
            var chanPage: ChanPage?
            if let d = data, let representation = ChanPage(data: d) {
                chanPage = representation
            }
            completionHandler(chanPage, response, error)
        })
    }

    func chanTask(_ board: String, thread: Int, completionHandler: @escaping (ChanThread?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        let url = URL(string: String(format: URLSession.chanAPIRoot+"/%@/thread/%d.json", board, thread))!
        return self.dataTask(with: URLRequest(url: url), completionHandler: { (data, response, error) in
            var chanThread: ChanThread?
            if let d = data, let representation = ChanThread(data: d) {
                chanThread = representation
            }
            completionHandler(chanThread, response, error)
        })
    }

}
