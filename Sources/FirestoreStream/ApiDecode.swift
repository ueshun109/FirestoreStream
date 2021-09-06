import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

private let notFound = NSError(
  domain: "com.ueshun.FirestoreStream",
  code: 404,
  userInfo: [NSLocalizedDescriptionKey: "Decoding failed."]
)

public extension Publisher where Output == DocumentSnapshot, Failure == Error {
  func apiDecode<T: Decodable>(
    as type: T.Type,
    file: StaticString = #file,
    line: UInt = #line
  ) -> AnyPublisher<T, FirestoreStreamError> {
    self
      .mapError { FirestoreStreamError(error: $0) }
      .flatMap { snapshot -> AnyPublisher<T, FirestoreStreamError> in
        if snapshot.exists {
          do {
            if let response = try snapshot.data(as: T.self) {
              return Just(response)
                .setFailureType(to: FirestoreStreamError.self)
                .eraseToAnyPublisher()
            }
          } catch {
            return Fail(error: FirestoreStreamError(error: error))
              .eraseToAnyPublisher()
          }
        }
        return Fail(error: FirestoreStreamError(error: notFound))
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
}

public extension Publisher where Output == QuerySnapshot, Failure == Error {
  func apiDecode<T: Decodable>(
    as type: T.Type,
    file: StaticString = #file,
    line: UInt = #line
  ) -> AnyPublisher<[T], FirestoreStreamError> {
    self
      .mapError { FirestoreStreamError(error: $0) }
      .flatMap { snapshot -> AnyPublisher<[T], FirestoreStreamError> in
        var result: [T] = []
        var _error: Error?
        snapshot.documents.forEach {
          do {
            if let response = try $0.data(as: T.self) {
              result.append(response)
            }
          } catch {
            _error = error
          }
        }
        if let error = _error {
          return Fail(error: FirestoreStreamError(error: error)).eraseToAnyPublisher()
        } else {
          return Just(result)
            .setFailureType(to: FirestoreStreamError.self)
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
}
