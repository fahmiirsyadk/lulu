open Module;

[@bs.module] external unified: unit => Js.t('a) = "unified";
[@bs.module] external guide: 'a = "remark-preset-lint-markdown-style-guide";
[@bs.module] external html: 'a = "remark-html";
[@bs.module] external markdown: 'a = "remark-parse";
[@bs.module] external report: 'a => 'a = "vfile-reporter";

let generate = (filepath: string) => {
  Js.Promise.(
    unified()##use(guide)##use(markdown)##use(html)##process(
      Node.Fs.readFileSync(filepath, `utf8),
    )
    |> then_(file => report(file) |> resolve)
    |> then_(err => Console.error(err) |> resolve)
  );
};

let getMdFiles = (files: array(string)) => {
  Js.Promise.(
    Belt.Array.map(files, file => generate(file))
    |> all
    |> then_(_ => resolve())
  );
};