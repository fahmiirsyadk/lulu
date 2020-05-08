open Module;
module Fs = Fs_Extra;

[@bs.val] external __dirname: string = "__dirname";
let resolvePath = (path: string) => Node.Path.resolve(__dirname, path);

let run = () => {
  let _ = {
    let time = now();
    Js.Promise.(
      Fs.copy(
        normalize(resolvePath({j|../templates/pages|j})),
        normalize({j|$cwd/src/pages|j}),
      )
      |> then_(_ => now() - time |> logMeasure |> resolve)
    );
  };
  ();
};