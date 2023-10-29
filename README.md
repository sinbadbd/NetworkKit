# NetworkKit

1. ApiURL Struct
```swift
struct ApiURL {
    enum Post {
        case post
    }
}
```

2. ApiURL.Auth Extension
```swift
extension ApiURL.Auth {
    func getURL() -> String {
        let baseURL = "http://localhost:8080/api/"
        var endPart = ""
        switch self {
        case .register: endPart = "/register"
        }
        return "\(baseURL)\(endPart)"
    }
}
```

3. Post Struct
```swift
struct Post: Decodable { 
    var name, Title: String?
    
}
```
4. ViewModel Declaration
```swift
    var cancellables = Set<AnyCancellable>()
```
5. Network Call
```swift
   // Construct the URL for the API endpoint
    let url = String(format: ApiURL.Post.post.getURL())
    let urlComponents = URLComponents(string: url)
    let endPoint = EndPoint(url: (urlComponents?.string)!, method: .get)

    // Make the network request using NetworkKit
    NetworkKit.shared.request(endPoint)
    .sink(
        receiveCompletion: { completion in
            // Handle the completion of the request (optional)
            NetworkKit.shared.handleCompletion(url: URL(string: endPoint.url)!, completion: completion)
        },
        receiveValue: { (response: Post) in
            // Process the response
            print(response)
        })
    .store(in: &cancellables)
```

