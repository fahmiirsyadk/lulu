open Module.Fs_Extra;
open Default_template;

let run = () => {
  let tasks = [|
    outputFile("src/pages/index.md", index()),
    outputFile("src/templates/default.re", layout()),
    outputFile("src/components/Header.re", ""),
  |];

  let _ = {
    Js.Console.timeStart("generate");
    Js.Promise.(
      tasks |> all |> then_(_ => Js.Console.timeEnd("generate") |> resolve)
    );
  };
  ();
};
