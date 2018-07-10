import Vapor
import Configuration


class VaporSrv: TestedServer {
    
    var router: EngineRouter!
    
    public var name: String { return "Vapor" }

    public func configure() throws {
        router = EngineRouter.default()
        
        Parse.api.forEach {
            let components = $0.1.split(separator: "/")
            let pathComponents = components.map { (s) -> PathComponent in
                if s.hasPrefix(":") {
                    return .parameter(String(s.suffix(from: s.index(s.startIndex, offsetBy: 1))))
                } else {
                    return .constant(String(s))
                }
            }
            
            router.on(methodFrom(string: $0.0), at: pathComponents) { req in
                return "Vapor: OK. \(req.debugDescription)"
            }
        }
    }
    
    public func run(host: String, port: Int) throws {
        let config = Config.default()
        
        var services = Services.default()
        services.register(router, as: Router.self)
        
        let app = try Application(config: config, environment: .detect(), services: services)
        
        try app.run()
    }
}

// MARK: -
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

