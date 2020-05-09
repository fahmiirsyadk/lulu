open Module;
module Fs = Fs_Extra;
module Global = NodeJs.Global;
module Path = NodeJs.Path;

let resolvePath = (path: string) => Path.resolve([|Global.dirname, path|]);

let run = () => {
  let _ = {
    let time = now();
    Js.Promise.(
      [|Node.Process.cwd(), "src", "pages"|]
      |> Path.join
      |> Path.normalize
      |> Fs.copy(resolvePath({j|../templates/pages|j}) |> Path.normalize)
      |> then_(_ => now() - time |> logMeasure |> resolve)
    );
  };
  ();
};