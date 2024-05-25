import lustre
import gleam/io
import lustretest/app

pub fn main() {
  io.println("Hello from lustretest!")
  let app = lustre.simple(app.init, app.update, app.view)
  let assert Ok(_) = lustre.start(app, "[data-lustre-app]", Nil)

  Nil
}
