import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

private let queue = DispatchQueue(label: "com.ueshun109.FirestoreStream", qos: .default)

public extension DocumentReference {
  func getDocument<T: Decodable>(
    source: FirestoreSource = .default,
    as: T.Type,
    file: StaticString = #file,
    line: UInt = #line
  ) -> AnyPublisher<T, FirestoreStreamError> {
    Future<DocumentSnapshot, Error> { completion in
      self.getDocument(source: source) { snapshot, error in
        if let error = error {
          completion(.failure(error))
        } else {
          completion(.success(snapshot!))
        }
      }
    }
    .subscribe(on: queue)
    .apiDecode(as: T.self)
  }

  func setDocument<T: Encodable>(
    data: T,
    merge: Bool = false,
    file: StaticString = #file,
    line: UInt = #line
  ) -> AnyPublisher<Void, FirestoreStreamError> {
    Future<Void, FirestoreStreamError> { completion in
      do {
        try self.setData(from: data, merge: merge) { error in
          if let error = error {
            completion(.failure(.init(error: error)))
          } else {
            completion(.success(()))
          }
        }
      } catch {
        completion(.failure(.init(error: error)))
      }
    }
    .subscribe(on: queue)
    .eraseToAnyPublisher()
  }

  func updateDocument<T: Encodable>(
    data: T,
    file: StaticString = #file,
    line: UInt = #line
  ) -> AnyPublisher<Void, FirestoreStreamError> {
    Future<Void, FirestoreStreamError> { completion in
      do {
        let fields = try Firestore.Encoder().encode(data)
        self.updateData(fields) { error in
          if let error = error {
            completion(.failure(.init(error: error)))
          } else {
            completion(.success(()))
          }
        }
      } catch {
        completion(.failure(.init(error: error)))
      }
    }
    .subscribe(on: queue)
    .eraseToAnyPublisher()
  }
}

public extension Query {
  func getDocuments<T: Decodable>(
    source: FirestoreSource = .default,
    as: T.Type,
    file: StaticString = #file,
    line: UInt = #line
  ) -> AnyPublisher<[T], FirestoreStreamError> {
    Future<QuerySnapshot, Error> { completion in
      self.getDocuments { snapshot, error in
        if let error = error {
          completion(.failure(error))
        } else {
          completion(.success(snapshot!))
        }
      }
    }
    .subscribe(on: queue)
    .apiDecode(as: T.self)
  }
}
