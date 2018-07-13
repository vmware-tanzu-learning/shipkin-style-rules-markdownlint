// @ts-check

"use strict";

const shared = require("./shared");

module.exports = {
  "names": [ "MDC-101", "no-contractions" ],
  "description": "Contractions",
  "tags": [ "vocabulary" ],
  "function": function MDC101(params, onError) {
    shared.forEachInlineChild(params, "text", function forToken(token) {
      let left = true;
      let match = /(ou'll|ou've|e'll|e've|u’re|e're|n't)/.exec(token.content);
      if (match) {
        const text = match[0].trim();
        const line = params.lines[token.lineNumber - 1];
        const column = line.indexOf(text) + 1;
        const length = text.length;
        shared.addErrorContext(onError, token.lineNumber,
          text, left, !left, [ column, length ]);
      }
    });
  }
};
