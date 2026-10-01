# Typst Templates

[Typst](https://typst.app) is a modern tool for writing documents, like LaTeX but simpler and much faster.
You write plain text with light markup (`= Title`, `*bold*`, `- list`) and Typst turns it into a PDF.
Styling lives in a separate template, so you focus on the content and the template takes care of the looks.
This repo has a few ready-to-use templates: pick one, write your text, and see the result live.

## Files

| File | What it is |
| --- | --- |
| `main.typ` | The example document. **Start here:** write your text in this file. |
| `lib.typ` | Colorful template with random blob shapes in the background. |
| `formal.typ` | Formal template with a red side bar showing the title and page number. |
| `bible.typ` | Two-column template in a Bible style. |
| `form.typ` | Draws the blob shapes. Only used by `lib.typ`, you don't need to touch it. |
| `cat.png` | Sample image used in `main.typ`. |

To switch templates, change the first line of `main.typ`:

```typ
#import "lib.typ": *      // colorful
#import "formal.typ": *   // formal
#import "bible.typ": *    // bible
```

## 1. Install Typst

Follow the instructions at **https://github.com/typst/typst#installation**.

Quick options:

- **Windows:** `winget install --id Typst.Typst`
- **macOS:** `brew install typst`
- **Linux:** check your package manager, or download the binary from the [releases page](https://github.com/typst/typst/releases)

Check it works:

```sh
typst --version
```

> Don't want to install anything? Use the web app at **https://typst.app**.

## 2. Export to PDF

From the terminal:

```sh
typst compile main.typ
```

Or use `typst watch main.typ` to recompile on every save.
