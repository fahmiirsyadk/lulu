open Module;

[@bs.module] external unified: unit => Js.t('a) = "unified";
[@bs.module] external guide: 'a = "remark-preset-lint-markdown-style-guide";
[@bs.module] external html: 'a = "remark-html";
[@bs.module] external markdown: 'a = "remark-parse";
[@bs.module] external report: 'a => 'a = "vfile-reporter";
[@bs.module] external matter: (string, 'a) => 'a = "vfile-matter";
[@bs.module "to-vfile"] external read: string => Js.Promise.t('a) = "read";

type file = {
  history: array(string),
  contents: string,
  data: Js.t({.}),
};

let matterAsync = file =>
  Js.Promise.(matter(file, {"strip": true}) |> resolve);

let generate = (filepath: Generate_metadata.t) => {
  Js.Promise.(
    read(filepath.path)
    |> then_(file => matterAsync(file))
    |> then_(file =>
         unified()##use(guide)##use(markdown)##use(html)##process(file)
       )
    |> then_(file =>
         {
           Console.log(file.data);
           Console.log(report(file));
           file.contents;
         }
         |> resolve
       )
    |> then_(ctx => Fs_Extra.outputFile(filepath.distPath, ctx) |> resolve)
  );
};

let getMdFiles = (files: array(Generate_metadata.t)) => {
  Js.Promise.(
    Belt.Array.map(files, file => generate(file))
    |> all
    |> then_(_ => resolve())
  );
};