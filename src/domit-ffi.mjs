import { Ok, Error } from "./gleam.mjs";

/**
 * Parses a string into a DOM.
 *
 * @param {string} string String to parse.
 * @param {string} mimetype Mimetype to parse.
 * @returns {XMLDocument|HTMLDocument} The parsed DOM.
 */
export function parse_dom_internal(string, mimetype) {
    return new DOMParser().parseFromString(string, mimetype);
}

/**
 * Gets a field from an object (UNCHECKED).
 *
 * @param {*} object Object to get a field from.
 * @param {string} field Field to get from the object.
 * @returns The field value.
 */
export function unsafe_get_field_internal(object, field) {
    return object[field];
}

/**
 * Calls a method on an object (UNCHECKED).
 *
 * @param {*} object Object on which to call the method.
 * @param {string} method Name of the method to call.
 * @param {Array} args Arguments to the method.
 * @returns The value returned by the method call.
 */
export function unsafe_call_method_internal(object, method, args) {
    return object[method](...args);
}

/**
 * Converts `null` and `undefined` to `Error(Nil)`.
 * Otherwise returns `Ok(object)`.
 *
 * @param {*} object Object to check for `null` or `undefined`.
 * @returns {Ok|Error} `Ok(object)` if it's not `null` or `undefined`; `Error(Nil)` otherwise.
 */
export function convert_nullable_to_result(object) {
    if (object == null) {
        return new Error(undefined);
    }
    return new Ok(object);
}
