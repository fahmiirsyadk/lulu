[@bs.module "fs-extra"]
external outputFile: (string, string) => Js.Promise.t(unit) = "outputFile";

let run = () => {
  let tasks = [|
    outputFile("src/pages/index.re", ""),
    outputFile("src/templates/default.re", ""),
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
