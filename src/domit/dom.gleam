import gleam/dynamic
import domit/document.{type Document, type HTMLDocument, type XMLDocument}

@external(javascript, "../domit-ffi.mjs", "parse_dom_internal")
fn parse_dom_internal(string: String, mimetype: String) -> dynamic.Dynamic

/// Parses an HTML string into an HTMLDocument.
pub fn parse_html(string: String) -> HTMLDocument {
  let doc = parse_dom_internal(string, "text/html")

  // Using the mimetype "text/html" always returns a HTMLDocument
  dynamic.unsafe_coerce(doc)
}

/// Parses an XML string into an XMLDocument.
/// If the string is invalid XML, the document will contain a "parsererror"
/// node.
pub fn parse_xml(string: String) -> XMLDocument {
  let doc = parse_dom_internal(string, "text/xml")

  // Using the mimetype "text/xml" always returns a XMLDocument
  dynamic.unsafe_coerce(doc)
}
