import Seagull
import NIOHTTP1
import Configuration

class SeagullSrv: TestedServer {
    var router: Router!
    var engine: Engine!

    public var name: String { return "Seagull" }

    public func configure() throws {
        router = Router()
    
        try Parse.api.forEach {
          try router.add(method: methodFrom(string: $0.0), relativePath: $0.1, handler: emptyHandler)
        }
    }
    
    public func run(host: String, port: Int) throws {
      engine = Engine(router: router)
      try engine.run(host: host, port: port)
    
      defer { try! engine.close() }
      try engine.waitForCompletion()
    }
}

// MARK: - 
func emptyHandler(_: SgRequest, _: SgRequestContext) -> SgResult {
  return SgResult.data(response: SgDataResponse.empty())
}

func methodFrom(string: String) -> HTTPMethod {
  switch string {
  case "GET":
    return .GET
  case "POST":
    return .POST
  case "PUT":
    return .PUT
  case "DELETE":
    return .DELETE
  default:
    fatalError("Unsupported HTTP method")
  }
}

