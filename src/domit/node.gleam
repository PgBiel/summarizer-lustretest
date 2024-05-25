import gleam/dynamic
import gleam/result
import gleam/javascript/array.{type Array}

/// JavaScript type Node
pub opaque type Node

/// JavaScript type NodeList
pub opaque type NodeList

@external(javascript, "../domit-node-ffi.mjs", "node_list_to_array")
pub fn node_list_to_array(node_list: NodeList) -> Array(Node)

pub fn node_list_to_list(node_list: NodeList) -> List(Node) {
  node_list_to_array(node_list)
  |> array.to_list
}

// -- fields --

@external(javascript, "../domit-ffi.mjs", "unsafe_get_field_internal")
fn unsafe_get_field_internal(node: Node, field: String) -> a

@external(javascript, "../domit-ffi.mjs", "convert_nullable_to_result")
fn convert_nullable_to_result(object: a) -> Result(a, Nil)

/// Value of field 'node.textContent'
pub fn text_content(node: Node) -> Result(String, Nil) {
  unsafe_get_field_internal(node, "textContent")
  |> convert_nullable_to_result
  |> result.map(dynamic.unsafe_coerce)
}
// -- methods --
