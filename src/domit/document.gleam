import gleam/result
import gleam/dynamic
import domit/element.{type Element}
import domit/node.{type NodeList}

/// JavaScript type HTMLDocument
pub opaque type HTMLDocument

/// JavaScript type XMLDocument
pub opaque type XMLDocument

/// JavaScript type Document
pub opaque type Document

/// JavaScript type DOMException
pub opaque type DOMException

/// Gets the global document (`document` object).
@external(javascript, "../domit-document-ffi.mjs", "global_document")
pub fn global() -> Document

pub fn from_html(html: HTMLDocument) -> Document {
  // Every HTMLDocument is a Document
  // See https://developer.mozilla.org/en-US/docs/Web/API/HTMLDocument
  dynamic.from(html)
  |> dynamic.unsafe_coerce
}

pub fn from_xml(xml: XMLDocument) -> Document {
  // Every XMLDocument is a Document
  // See https://developer.mozilla.org/en-US/docs/Web/API/XMLDocument
  dynamic.from(xml)
  |> dynamic.unsafe_coerce
}

// -- methods --

@external(javascript, "../domit-ffi.mjs", "unsafe_call_method_internal")
fn unsafe_call_method_internal(
  document: Document,
  method: String,
  args: List(a),
) -> b

@external(javascript, "../domit-ffi.mjs", "convert_nullable_to_result")
fn convert_nullable_to_result(object: a) -> Result(a, Nil)

@external(javascript, "../domit-document-ffi.mjs", "try_dom_exception")
fn try_dom_exception(func: fn() -> a) -> Result(a, DOMException)

pub fn get_element_by_id(
  document: Document,
  string: String,
) -> Result(Element, Nil) {
  unsafe_call_method_internal(document, "getElementById", [string])
  |> convert_nullable_to_result
  |> result.map(dynamic.unsafe_coerce)
}

pub fn query_selector(
  document: Document,
  selector: String,
) -> Result(Result(Element, Nil), DOMException) {
  use <- try_dom_exception

  unsafe_call_method_internal(document, "querySelector", [selector])
  |> convert_nullable_to_result
  |> result.map(dynamic.unsafe_coerce)
}

pub fn query_selector_all(
  document: Document,
  selector: String,
) -> Result(NodeList, DOMException) {
  use <- try_dom_exception

  unsafe_call_method_internal(document, "querySelectorAll", [selector])
}
