

public protocol TestedServer {
  var name: String { get }

  func configure() throws
  func run(host: String, port: Int) throws
}

