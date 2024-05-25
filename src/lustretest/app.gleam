import lustre/attribute
import lustre/event
import lustre/element.{type Element}
import lustre/element/html
import lustretest/summarizer.{type SumModel}

pub type Model {
  Model(user_input: String, sum_model: SumModel)
}

pub type Message {
  InputChanged(String)
}

pub fn init(_flags: Nil) -> Model {
  Model("", summarizer.init(Nil))
}

pub fn update(model: Model, message: Message) -> Model {
  case message {
    InputChanged(new_input) -> {
      let Model(_, sum_model) = model
      let sum_message = summarizer.BodyChanged(new_input)
      let sum_model = summarizer.update(sum_model, sum_message)

      Model(new_input, sum_model)
    }
  }
}

pub fn view(model: Model) -> Element(Message) {
  let Model(user_input, sum_model) = model
  let summary =
    summarizer.view(sum_model)
    |> element.map(fn(sum_msg) {
      // BodyChanged and InputChanged are equivalent messages.
      // The input and the body to be summarized are the same.
      let summarizer.BodyChanged(body) = sum_msg
      InputChanged(body)
    })

  html.div([attribute.style([#("text-align", "center")])], [
    html.h1([], [element.text("Hey there!")]),
    html.br([]),
    element.text("You gave: " <> user_input),
    html.br([]),
    html.strong([], [element.text("Headings:")]),
    html.br([]),
    summary,
    html.br([]),
    html.input([attribute.id("your-input"), event.on_input(InputChanged)]),
  ])
}
