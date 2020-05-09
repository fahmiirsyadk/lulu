open Module;
open NodeJs;
open Process;
open Global;
module Fs = Fs_Extra;
module Path = NodeJs.Path;

let resolvePath = (path: string) => Path.resolve([|dirname, path|]);

let run = () => {
  let _ = {
    let time = now();
    Js.Promise.(
      [|cwd(process), "src", "pages"|]
      |> Path.join
      |> Path.normalize
      |> Fs.copy(resolvePath({j|../templates/pages|j}) |> Path.normalize)
      |> then_(_ => now() - time |> logMeasure |> resolve)
    );
  };
  ();
};