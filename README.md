<p align="center">
  <img height="100" src="./lulu.png" />
</p>

<h1 align="center">✨Lulu ✨</h1>

<p align="center">
Simple as F static site generator, create static site without breaking a sweet
</p>

## Usage

### Init project

- create your project folder
- then run `npx lulu init`

### Build project

- run `npx lulu build`

## Example

### Reason file

```re
module S = Silica.HTML;
module P = Silica.Property;

// DATA
let animals = ["macan", "hiu", "kura-kura", "panda"];

// LOGIC
let listAnimal = animals |> List.map(animal => S.li([], S.text(animal)));

let main =
  S.div([P.style("padding: 20px; background-color: pink;")],
    [
      S.h1([], S.text("FORM JUDUL")),
      S.label([ P.for_("newslatter-email-input")], S.text("Email")),
      S.input(
        [ P.type_("email") // TODO VARIANT
        , P.id("newslatter-email")
        , P.name("email")
        , P.placeholder("you@example.com")
        , P.required(true) ]
        , [])
        , S.ol([], listAnimal)
    ]);

let head =
  S.head([], [
    S.title([], S.text("judul_browser"))
    , S.meta([ P.charset("utf-8")], [])
    , S.meta([
      P.property("og:title")
      , P.content("Silica test")],[])
  ]);

let render = [main] |> S.body([P.style("margin: 0; padding: 0;")]);
```

### Markdown file

its also support md file, if you don't want hardcode. Just create wrapper in template folder and DONE , a page created. Or just write the md file without any configuration, Lulu will handle it AUTOMATICALLY.

```markdown
# ABSTRACTION

## this is some sample of md .file
```
