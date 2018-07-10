import Configuration

var host = "::1"
var port = 8010

if CommandLine.arguments.count == 4 {
    host = CommandLine.arguments[1]
    port = Int(CommandLine.arguments[2]) ?? port
}

do {
  let server = VaporSrv()

  print("Configuring performance test server: \(server.name)")
  try server.configure()

  print("Starting performance test server: \(server.name)")
  try server.run(host: host, port: port)

} catch let err {
    print("Couldn't start server: \(err)")
}