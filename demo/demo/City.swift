import Foundation

struct City: Codable {
  var name: String
  var capital: Bool
  var state: String
  var country: String
  var population: Int
  var regions: [String]
}
