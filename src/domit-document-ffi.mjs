import { Ok, Error } from "./gleam.mjs";

/**
 * Runs a function and returns it output, catching a DOMException, which is
 * returned as an `Error`. Other exception types are not caught.
 *
 * @param {(any) => any} func Function to run.
 * @returns {Ok|Error} If the function ran without errors, returns `Ok(func())`.
 * If it threw a DOMException, returns `Error(err)`. If it threw some
 * other error, the error is re-thrown, as it is unexpected.
 */
export function try_dom_exception(func) {
    try {
        return new Ok(func());
    } catch (err) {
        if (err instanceof DOMException) {
            return new Error(err);
        } else {
            throw err;
        }
    }
}

/**
 * Returns the global `Document`.
 *
 * @returns {Document} The global document instance.
 */
export function global_document() {
    return document;
}
