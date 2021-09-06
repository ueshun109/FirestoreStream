import Combine
import FirebaseFirestore
import FirestoreStream

final class ViewModel {
  private let db = Firestore.firestore()
  private var cancellables: [AnyCancellable] = []

  func fetch() {
    db
      .collection("cities")
      .document("SF")
      .getDocument(as: City.self)
      .sink { result in
        switch result {
        case let .failure(error):
          print(error.message)
        case .finished:
          print("finished")
        }
      } receiveValue: { value in
        print(value)
      }
      .store(in: &self.cancellables)
  }

  func save(city: City) {
    db
      .collection("cities")
      .document("LA")
      .setDocument(data: city)
      .sink { result in
        switch result {
        case let .failure(error):
          print(error.message)
        case .finished:
          print("finished")
        }
      } receiveValue: { value in
        print(value)
      }
      .store(in: &self.cancellables)
  }

  func update(city: City) {
    db
      .collection("cities")
      .document("LA")
      .updateDocument(data: city)
      .sink { result in
        switch result {
        case let .failure(error):
          print(error.message)
        case .finished:
          print("finished")
        }
      } receiveValue: { value in
        print(value)
      }
      .store(in: &self.cancellables)
  }

  func fetchAll() {
    db
      .collection("cities")
      .getDocuments(as: City.self)
      .sink { result in
        switch result {
        case let .failure(error):
          print(error.message)
        case .finished:
          print("finished")
        }
      } receiveValue: { value in

        print(value)
      }
      .store(in: &self.cancellables)
  }
}
