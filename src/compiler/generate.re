open Module;
open Default_template;

let run = () => {
  let tasks = [|
    Fs_Extra.outputFile("src/pages/index.md", index()),
    Fs_Extra.outputFile("src/templates/default.re", layout()),
    Fs_Extra.outputFile("src/components/Header.re", ""),
    Fs_Extra.outputFile({j|$cwd/lulu_config.re|j}, ""),
  |];

  let _ = {
    let time = now();
    Js.Promise.(
      tasks |> all |> then_(_ => now() - time |> logMeasure |> resolve)
    );
  };
  ();
};