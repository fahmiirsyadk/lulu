open Module;
type file = {
  history: array(string),
  [@bs.as "contents"]
  _contents: string,
  data: Js.t({.}),
};

type unifiedType;
[@bs.module] external unified: unit => unifiedType = "unified";
[@bs.send.pipe: unifiedType] external use: unifiedType => unifiedType = "use";
[@bs.send.pipe: unifiedType]
external process: Js.Promise.t('a) => file = "process";
[@bs.module]
external guide: unifiedType = "remark-preset-lint-markdown-style-guide";
[@bs.module] external html: unifiedType = "remark-html";
[@bs.module] external markdown: unifiedType = "remark-parse";
[@bs.module] external report: 'a => 'a = "vfile-reporter";
[@bs.module] external matter: (string, Js.t({..})) => 'a = "vfile-matter";
[@bs.module "to-vfile"] external read: string => Js.Promise.t('a) = "read";

let matterAsync = file =>
  Js.Promise.(matter(file, {"strip": true}) |> resolve);

let generate = (filepath: Generate_metadata.t) => {
  Js.Promise.(
    read(filepath.path)
    |> then_(file => matterAsync(file))
    |> then_(file =>
         unified()
         |> use(guide)
         |> use(markdown)
         |> use(html)
         |> process(file)
         |> resolve
       )
    |> then_(file =>
         {
           Console.log(report(file));
           file._contents;
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