open Module;

[@bs.module] external unified: unit => Js.t('a) = "unified";
[@bs.module] external guide: 'a = "remark-preset-lint-markdown-style-guide";
[@bs.module] external html: 'a = "remark-html";
[@bs.module] external markdown: 'a = "remark-parse";
[@bs.module] external report: 'a => 'a = "vfile-reporter";
[@bs.module "to-vfile"] external read: string => Js.Promise.t('a) = "read";
[@bs.module "path"] external extname: string => string = "extname";

type file = {
  history: array(string),
  contents: string,
};

let generateFolder = (filename: string) => {
  let filenoExtn = () =>
    Js.String.replace(extname(filename), "", Node.Path.basename(filename));
  Node.Path.join([|
    cwd,
    "dist",
    filenoExtn() === "index" ? "" : filenoExtn(),
  |])
  |> normalize;
};

let logMd = (file: file): Js.Promise.t(unit) => {
  Console.log(report(file));
  let filename = file.history[1];
  let folderTarget =
    filename
    |> Js.String.replace(Node.Path.basename(filename), "index.html", _)
    |> Js.String.replace(
         Node.Path.join([|"src", "pages"|]) |> normalize,
         generateFolder(filename) |> normalize,
         _,
       );

  Fs_Extra.outputFile(folderTarget, file.contents);
};

let generate = (filepath: string) => {
  Js.Promise.(
    read(filepath)
    |> then_(file => resolve(file))
    |> then_(file =>
         unified()##use(guide)##use(markdown)##use(html)##process(file)
       )
    |> then_(file => logMd(file) |> resolve)
  );
};

let getMdFiles = (files: array(string)) => {
  Js.Promise.(
    Belt.Array.map(files, file => generate(file))
    |> all
    |> then_(_ => resolve())
  );
};