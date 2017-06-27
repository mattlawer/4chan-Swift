import Foundation

func usage() {
    print("Usage : 4chan -b <board> [-t <thread> | -p <page>]\n");
    print("\t-b <board> : \n");
    print("\t-t <thread> : the thread n°\n");
    print("\t-p <page> : the board page to load\n");
    print("\t-h show this help screen\n\n");

    print("example:\n\t4chan -b r -t 123456789\n");
}

var cBoard: String?
var cThread: Int?
var cPage: Int = 1

while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, "b:t:o:p:h"), option != -1 {
    switch UnicodeScalar(CUnsignedChar(option)) {
    case "b":
        cBoard = String(cString: optarg)
    case "t":
        cThread = Int(String(cString: optarg))
    case "p":
        cPage = Int(String(cString: optarg)) ?? 1
    case "h":
        usage()
        exit(0)
    default:
        if isprint(optopt) != 0 {
            print(String(format: "Unknown option -%c", optopt))
        } else {
            print(String(format: "Unknown option -\\x%x", optopt))
        }
    }
}

if let board = cBoard {
    if let threadNum = cThread {
        // Print thread
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.chanTask(board, thread: threadNum) { (thread, response, error) in
            if let t = thread {
                print(t.description)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    } else {
        // List threads
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.chanTask(board, page: 1) { (page, response, error) in
            if let p = page {
                print(p.description)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    }
} else {
    print("No board provided, use -b argument to select a board.")
}
