// @ts-check

"use strict";

const shared = require("./shared");

module.exports = {
  "names": [ "MDC-100", "no-sentence-break-in-line" ],
  "description": "Sentence Break within a line",
  "tags": [ "whitespace" ],
  "function": function MDC100(params, onError) {
    shared.forEachInlineChild(params, "text", function forToken(token) {
      let left = true;
      let match = /(([a-zAz0-9`\"\'\]\\>\&}\)]{2})(\?|\.|\!|\:)\s+)/.exec(token.content);
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
