import Foundation

public struct FirestoreStreamError: Codable, Equatable, LocalizedError {
  public let dump: String
  public let file: String
  public let line: UInt
  public let message: String

  public init(
    error: Error,
    file: StaticString = #fileID,
    line: UInt = #line
  ) {
    var string = ""
    Swift.dump(error, to: &string)
    self.dump = string
    self.file = String(describing: file)
    self.line = line
    self.message = error.localizedDescription
  }
}
