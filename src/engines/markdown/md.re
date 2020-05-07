open Module;

[@bs.module] external remark: unit => Js.t('a) = "remark";
[@bs.module] external guide: 'a = "remark-preset-lint-markdown-style-guide";
[@bs.module] external html: 'a = "remark-html";
[@bs.module] external report: Js.Promise.error => 'a = "vfile-reporter";

let generate = (filepath: string) => {
  Js.Promise.(
    remark()##use(guide)##use(html)##process(filepath)
    |> then_(file => Console.log(file) |> resolve)
    |> catch(err => report(err) |> resolve)
  );
};

let getMdFiles = (files: array(string)) => {
  Js.Promise.(
    Belt.Array.map(files, file => generate(file))
    |> all
    |> then_(_ => resolve())
  );
};