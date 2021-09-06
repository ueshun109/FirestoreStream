import SwiftUI

struct ContentView: View {
  private let viewModel = ViewModel()

  var body: some View {
    List {
      Button("fetch a document") {
        viewModel.fetch()
      }
      Button("save a document") {
        let city = City(
          name: "Los Angeles",
          capital: false,
          state: "CA",
          country: "USA",
          population: 3900000,
          regions: ["west_coast", "socal"]
        )
        viewModel.save(city: city)
      }
      Button("update a document") {
        let city = City(
          name: "Los Angeles",
          capital: false,
          state: "CA",
          country: "USA",
          population: 3900000,
          regions: ["west_coast", "norcal"]
        )
        viewModel.update(city: city)
      }
      Button("fetch all documents") {
        viewModel.fetchAll()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
