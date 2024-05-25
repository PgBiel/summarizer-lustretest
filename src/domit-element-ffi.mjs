import { Ok, Error } from "./gleam.mjs";

/**
 * Attempts to cast an `Element` instance to `HTMLElement`.
 *
 * @param {Element} element Element to cast
 * @returns {Ok|Error} Returns a `Result` wrapping the given element. If it was
 * an HTMLElement, returns `Ok(element)`. Otherwise, `Error(element)`.
 */
export function try_to_html(element) {
    if (element instanceof HTMLElement) {
        return new Ok(element);
    } else {
        return new Error(element);
    }
}

/**
 * Attempts to cast a `Node` instance to `Element`.
 *
 * @param {Node} node Node to cast
 * @returns {Ok|Error} Returns a `Result` wrapping the given node. If it was
 * an `Element`, returns `Ok(node)`. Otherwise, `Error(node)`.
 */
export function try_from_node(node) {
    if (node instanceof Element) {
        return new Ok(node);
    } else {
        return new Error(node);
    }
}
