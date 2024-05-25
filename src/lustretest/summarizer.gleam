import gleam/list
import gleam/iterator
import gleam/result
import lustre/element.{type Element, text} as _
import lustre/element/html
import domit/dom
import domit/document
import domit/element
import domit/node

pub opaque type SumModel {
  SumModel(body: String, headings: List(String))
}

pub type SumMsg {
  BodyChanged(String)
}

/// Build a SumModel instance by taking a body and summarizing it.
fn summarize(body: String) -> SumModel {
  let doc =
    body
    |> dom.parse_html
    |> document.from_html

  let heading_nodes =
    doc
    |> document.query_selector_all("h1")
    |> result.map(node.node_list_to_list)
    |> result.unwrap(or: [])

  let headings =
    heading_nodes
    |> iterator.from_list
    |> iterator.map(fn(node) {
      let assert Ok(elem) = element.try_from_node(node)
      let assert Ok(html_elem) = element.try_to_html(elem)
      html_elem
    })

  headings
  |> iterator.map(element.inner_text)
  |> iterator.to_list
  |> SumModel(body, _)
}

pub fn init(_flags: Nil) -> SumModel {
  SumModel(body: "", headings: [])
}

pub fn update(_model: SumModel, msg: SumMsg) -> SumModel {
  case msg {
    BodyChanged(body) -> summarize(body)
  }
}

pub fn view(model: SumModel) -> Element(SumMsg) {
  let SumModel(_, headings: headings) = model
  let list_items =
    headings
    |> list.map(fn(heading) { html.li([], [text(heading)]) })

  html.ul([], list_items)
}
