/**
 * Converts a `NodeList` instance to an array.
 *
 * @param {NodeList} node_list `NodeList` to convert to an array.
 * @returns {Array<Node>} Array of nodes in the NodeList.
 */
export function node_list_to_array(node_list) {
    return Array.from(node_list);
}
