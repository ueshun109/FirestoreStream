<a href="https://github.com/ueshun109/FirestoreStream/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-green.svg"></a>
<a href="https://github.com/apple/swift-package-manager" alt="Firestore on Swift Package Manager"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" /></a>

# FirestoreStream
Cloud Firestore Wrapper with Combine.
Cloud Firestore SDK return value can be treated as Publisher.
Also the publisher output values ​​are mapped to type confirmed to decodable. 

## Usage
All the return value of this framework is `AnyPublisher`, and you can receive the value with a general publisher operators such as `sink`.  
```swift
let db = Firestore.firestore()

db
  .collection("cities")
  .document("SF")
  .getDocument(City.self)
  .sink { result in
  
  } receiveValue: { document in
    
  }
  .store(in: &self.cancellables)
```

## APIs
List of supported APIs.
|api|content|
|---|---|
|`getDocument<T>(as: T)`|Fetch a single document which mapped to Decodable object.|
|`getDocuments<T>(as: T)`|Fetch documents which mapped to Decodable object.|
|`setDocument<T>(data: T)`|Save a single object which confirmed to Encodable.|
|`updateDocument<T>(data: T)`|Update a single object which confirmed to Encodable.|

## Installation
Only support via Swift package manager installation.

```swift
dependencies: [
  .package(url: "https://github.com/ueshun109/FirestoreStream.git", from: "0.1.0")
]
```
