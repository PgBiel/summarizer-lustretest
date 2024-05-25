import gleam/dynamic
import domit/node.{type Node}

/// JavaScript Element type
pub opaque type Element

/// JavaScript HTMLElement type
pub opaque type HTMLElement

/// Attempts to cast an Element to an HTMLElement, otherwise returns the
/// original Element.
@external(javascript, "../domit-element-ffi.mjs", "try_to_html")
pub fn try_to_html(element: Element) -> Result(HTMLElement, Element)

/// Attempts to cast a Node to an Element, otherwise returns the original Node.
@external(javascript, "../domit-element-ffi.mjs", "try_from_node")
pub fn try_from_node(node: Node) -> Result(Element, Node)

/// Casts an Element to a Node.
pub fn to_node(element: Element) -> Node {
  // SAFETY: Elements are always Nodes.
  dynamic.from(element)
  |> dynamic.unsafe_coerce
}

// -- fields --

@external(javascript, "../domit-ffi.mjs", "unsafe_get_field_internal")
fn unsafe_get_field_internal(element: Element, field: String) -> a

@external(javascript, "../domit-ffi.mjs", "unsafe_get_field_internal")
fn unsafe_get_html_field_internal(element: HTMLElement, field: String) -> a

/// Value of the field 'element.id'
pub fn id(element: Element) -> String {
  // SAFETY: element.id is always a string
  unsafe_get_field_internal(element, "id")
}

/// Value of the field 'element.tagName'
pub fn tag_name(element: Element) -> String {
  // SAFETY: element.tagName is always a string
  unsafe_get_field_internal(element, "tagName")
}

/// Value of the field 'element.innerHTML'
pub fn inner_html(element: Element) -> String {
  // SAFETY: element.innerHTML is always a string
  unsafe_get_field_internal(element, "innerHTML")
}

/// Value of the field 'element.innerText'
pub fn inner_text(element: HTMLElement) -> String {
  // SAFETY: element.innerText is always a string
  unsafe_get_html_field_internal(element, "innerText")
}
// -- methods --
