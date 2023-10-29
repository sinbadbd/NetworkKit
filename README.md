# NetworkKit

- API URL
```swift
struct ApiURL {
    enum Post {
        case post
    }
}
```

- API URL
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

- Model
```swift
struct Post: Decodable { 
    var name, Title: String?
    
}
```
- Add this ViewModel
```swift
    var cancellables = Set<AnyCancellable>()
```
-- Network Call
```swift
   func getPosts(){
    let url = String(format: ApiURL.Post.post.getURL())
    let urlComponents = URLComponents(string: url)
    let endPoint = EndPoint(url: (urlComponents?.string)!, method: .get)

    NetworkKit.shared.request(endPoint)
    .sink(
        receiveCompletion: { completion in
            NetworkKit.shared.handleCompletion(url: URL(string: endPoint.url)!, completion: completion) // optional 
        },
        receiveValue: { (response: Post) in
          print(response)
        })
    .store(in: &cancellables)
    }
```

