## 4chan-Swift
Browse 4chan like a boss with a Swift API.

Based on [4chan-API](https://github.com/4chan/4chan-API).

## Installation
	git clone https://github.com/mattlawer/4chan-Swift.git
	cd 4chan-Swift
	make
	make install

## Swift API Usage
Import the files from the API folder to your project and you're good to go !

Use it just like a regular URLSession dataTask...

```swift
let session = URLSession.shared // You also could use your own session

let board = "wg" // The board you want
let threadNum = 6942115 // The thread #
session.chanTask(board, thread: threadNum) { (thread, response, error) in
	// just use the ChanThread object named thread here 😋
}.resume()
```
Or
```swift
let page = 3 // the page you want to load
session.chanTask(board, page: page) { (page, response, error) in
	// just use the ChanPage object named page here 😋
}.resume()
```

## Command-Line Tool Usage
	Usage : 4chan -b <board> [-t <thread> | -p <page>]
		-b <board> : 
		-t <thread> : the thread n°
		-p <page> : the board page to load
		-h show this help screen
		
	example:
		4chan -b r -t 123456789

![](http://i64.tinypic.com/2dgvlv7.png "4chan -b wg")
![](http://i63.tinypic.com/2jche1v.png "4chan -b wg -t 6942115")
