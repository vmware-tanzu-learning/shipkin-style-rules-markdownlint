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

1.  Install
    [Visual Studio Code](https://code.visualstudio.com/download)
    (if not already).

1.  Install *markdownlint* extension from extension view in
    Visual Studio Code.

    See the accompanying
    [site for details of Markdown Rules](https://github.com/DavidAnson/markdownlint)
    for details of extension and Markdown rules.

### Installation

If you want the easiest install, run install script.
It is supported on Linux or Mac OSX distributions, although feel free to
add Windows support if you must.

The installation assumes default settings installation under the user
home directory:

-   Linux:
    `.config/Code/User/settings.json`
-   Mac:
    `Library/Application \Support/Code/User/settings.json`

    **Note**: On Mac OSX, the `.vscode` and `Library` folders will be
    hidden in Finder.

The install script will do the following:

-   Backup your existing `settings.json` to `settings.json.backup`.

-   Install new settings.json

    **Note**: The new settings will replace your original settings, you
    will need to manually merge from the `settings.json.backup` file.

Steps:

-   Clone this project to machine where Visual Studio Code is installed
    and you desire to run markdownlint.

-   Run the install from the root project directory:

    ```bash
    ./install.sh
    ```

-   Optionally merge back your user settings.
    You can access directly from Visual Studio Code via:

    - `Cmd-,` on Mac OSX
    - `Ctrl+,` on Linux

### Uninstall

If you desire to remove the custom settings and rules, you may run the
`./uninstall.sh` script directly from the project root.
It will:

-   Restore user settings to the backup created during the install.
    **Note**:  If you made changes to user settings since the install
    you will need to merge to the backup.

-   Remove the custom rule files.

### Manual Installation

1.  Merge the `settings.json` into your Visual Studio Code User
    Settings.
    You can do this in one of three ways:

    -   Globally through the IDE by `Cmd-,` on Mac OSX, or `Ctrl+,` on
        Windows.

    -   Update the User Settings file directly:

        -   On Mac OSX,
            `~/Library/Application Support/Code/User/settings.json`

    -   You may set at project level by putting `settings.json` in
        project relative directory `.vscode/settings.json`

1.  Install the custom rules by downloading the contents from `src`
    folder and putting into a named directory referenced by the
    `markdownlint.customRules` entries.

    The default assumption is referenced from your home directory:
    `~/.vscode/markdownlint/custom-rules/`, although it would be
    whereever you chose.

    **Note:
    If Visual Studio Code does not pick load or recognize the
    custom rules, replace the user home shortcut with an absolute
    path.**

## Usage

1.  Author some markdown code in Visual Studio code, or you can open
    `exampleFaultyDoc.md` file to see a 'broken' file.

1.  Open *Problem View* - You can enable by navigating to
    *View Menu >> Problems*, or `Shift-Cmd-M` on Mac OSX, or
    `Shift+Ctrl+M` on Windows.

1.  View the problem pane, click on associated problem to navigate to
    offense in the markdown editor.

1.  Fix it!

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

Unordered lists must be annotated with a dash.

The associated markdownlint configuration is via:

- MD004 style property set to dash.
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

# Known Issues

1.  End of sentence patterns do not always work.
    The associated regex expression in `sentence-end-line.js` needs some
    love.

1.  Handling indentation whitespace 'flakiness'.

    -   The rules are also very precise for both the one and multi-line
        scenarios.

        Watch out carefully to maintain a four space indentation for
        multi-line lists.

        If you are having issues with one-space on single line lists,
        try adding single empty line between list elements and keep the
        four space indentation.

    -   VSC may occasionally "get confused" on the configured
        indentation and put two space, instead of four.
        Check you configuration, and/or restart VSC.

    -   If markdownlint plugin gives a false positive, try to either cut
        and paste the offending block, or restart VSC.

# New Feature Candidates

## Enhanced install and uninstall scripts

-   Ability to parameterize install directory
    Default is home directory VSC installation

-   Ability to set rule configuration at the workspace versus user level

## Custom Shipkin rules

1.  End of line, excluding:
    - Links (if the link starts at the BOL)
    - github Links (if the link starts at the BOL)
    - Code blocks

1.  Lazy ordered lists
