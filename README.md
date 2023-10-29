# NetworkKit

1. ApiURL Struct
   
```swift
// The `ApiURL` struct is a foundational component of the application that helps define different API endpoints. It simplifies endpoint management and provides an organized way to access them.

// Properties:
// - `Post`: An enum representing various API endpoints related to posts.

struct ApiURL {
    enum Post {
        case post
    }
}
```

2. ApiURL.Auth Extension
```swift
// ### ApiURL.Auth Extension
//
// This extension extends the capabilities of `ApiURL` by allowing you to generate URLs for authentication-related endpoints. It centralizes the URL construction process for these endpoints.

// Method:
// - `getURL()`: Constructs and returns the URL for the selected authentication endpoint.

// Returns:
// - A string representing the URL for the chosen authentication endpoint.

extension ApiURL.Auth {
    func getURL() -> String {
        let baseURL = "http://localhost:8080/api/"
        var endPart = ""
        switch self {
        case .post: endPart = "/post"
        }
        return "\(baseURL)\(endPart)"
    }
}
```

3. Post Struct
```swift
// ### Post Struct
//
// The `Post` struct is a model that plays a crucial role in decoding JSON responses received from the API. It contains properties for post-related information.

// Properties:
// - `name`: A string representing the name associated with the post.
// - `Title`: A string representing the title of the post.

struct Post: Decodable { 
    var name, Title: String?
    
}
```
4. ViewModel Declaration
```swift
// ### ViewModel Declaration
//
// This ViewModel is used to manage subscriptions to Combine publishers. It keeps track of Combine subscriptions, allowing you to handle asynchronous events in your application.

// Properties:
// - `cancellables`: A set used to store `AnyCancellable` objects, which manage Combine framework subscriptions.

    var cancellables = Set<AnyCancellable>()
```
5. Network Call
```swift
// ### Network Call
//
// This code snippet represents a network call to retrieve posts from a specific API endpoint using the NetworkKit library. It demonstrates how to initiate a network request and handle the response using Combine.

// Method:
// - `getPosts()`: Initiates a network request to fetch posts from the API.

// Workflow:
// 1. It constructs the URL for the API endpoint using `ApiURL.Post.post.getURL()` and creates an `EndPoint` object for the network request.
// 2. It uses the `NetworkKit` shared instance to make the network request.
// 3. It leverages Combine to handle the response, including completion and value handling.
// 4. It stores Combine subscriptions in the `cancellables` property, allowing for proper management of subscriptions.

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

