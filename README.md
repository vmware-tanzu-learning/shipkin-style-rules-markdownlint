# Shipkin Style Rules for Markdownlint

This project is an accompanying set of markdownlint rules that comply
with a subset of PAL Shipkin rules.
It was incepted to leverage markdownlint to flag most common types of
markdown and shipkin style exceptions.

The setup tailors to Visual Studio Code IDE, although the custom rule
sets should work with David Anson's markdownlint supported Node-friendly
editors.

The project is a currently in a crude state, feel free to contribute and
improve.

## Setup

Follow these steps to configure markdownlint and associated custom:
rules:

-   Install
    [Visual Studio Code](https://code.visualstudio.com/download)
    (if not already).

-   Install *markdownlint* extension from extension view in
    Visual Studio Code.

    See the accompanying
    [site for details of Markdown Rules](https://github.com/DavidAnson/markdownlint)
    for details of extension and Markdown rules.

-   Merge the `settings.json` into your Visual Studio Code User
    Settings.
    You can do this in one of three ways:

    1.  Globally through the IDE by `Cmd+,` on Mac OSX, or `Cntrl+,` on
        Windows.

    1.  Update the User Settings file directly:

        -   On Mac OSX,
            `~/Library/Application Support/Code/User/settings.json`

    1.  You may set at project level by putting `settings.json` in
        project relative directory `.vscode/settings.json`

-   Install the custom rules by downloading the contents from `src`
    folder and putting into a named directory referenced by the
    `markdownlint.customRules` entries.

    The default assumption is referenced from your home directory:
    `~/.vscode/markdownlint/custom-rules/`, although it would be
    whereever you chose.

    **Note: If Visual Studio Code does not pick load or recognize the
    custom rules, replace the user home shortcut with an absolute
    path.**

## Usage

-   Author some markdown code in Visual Studio code, or you can open
    `exampleFaultyDoc.md` file to see a 'broken' file.

-   Open *Problem View* - You can enable by navigating to
    *View Menu >> Problems*, or Shift+Cmd+M on Mac OSX, or Shift-Ctrl-M
    on Windows.

-   View the problem pane, click on associated problem to navigate to
    offense in the markdown editor.

-   Fix it.

## Notes on the supplied user settings and custom rules

There are some gaps between the default markdownlint rules
and the Shipkin guidelines.:

1. Too restrictive
1. Need configuration
1. Need additional custom rules

The following are areas of customization in the user settings and/or
custom rules:

### Indentation and List Spacing Rules

The indentation rules are set to 4 spaces.
This is both a Shipkin and Google recommendation.

Multi-line lists need to honor the indentation; however, single line
lists may still maintain spacing of 1.

The associated markdownlint configuration is via:

- MD007 ident property set to 4
- MD030 has properties for ordered and undered list.

### Line Length

Line length rules are relaxed for links and headings, MD013 is turned
off.
VSC line length ruler is set to 72 via `editor.rulers` - the user
should visually check, given markdownlint will not warn.

### Headers

Duplicate headers and multiple top level headings in a
document are allowed, therefore the following are disabled:

- MD024
- MD025

All lab documents should have a *Purpose* section at top of the
document:

- MD043 is set accordingly.

## Trailing Whitespace

Most IDEs provide option to auto-trim trailing whitespace.
VSC provides via `files.trimTrailingWhitespace` option.

## End of Sentence require Line Break

Shipkin guideline recommend that multiple sentences should not exist on
the same line.

There are two reasons for this, both stemming from the characteristic
of source control operating at line level:

- Merge conflicts
- Differences

The `sentence-end-line.js` rule file exposes a custom rule `MDC100`
to detect for most end-of-sentence break patterns on a single line.

**Note:** this rule has regex bug that does not detect special
characters properly

## No English Contractions

The `no-contractions.js` rule file exposes a custom rule `MDC101` to
detect for the most common English contractions used in the labs.

Feel free to add to the list as you see fit.

# Adding new rules

Feel free to recommend or add new rules.
The general procedure is as follows:

1.  Identify a rule tag, name and identifier.
    The identifier should be `MDC`, short for "Markdown Custom".

1.  Review and follow
    [David Anson's docs on creating custom rule](https://github.com/DavidAnson/markdownlint/blob/master/doc/CustomRules.md)

1.  Or, use the `no-contractions.js` as an example.

1.  Add the new rule file to your workstation directory where you have
    installed the provided custom rule files.

1.  Add an entry to `markdownlint.customRules` with location of your new
    rule file.

1.  Consider contributing here either directly, or as a pull request!