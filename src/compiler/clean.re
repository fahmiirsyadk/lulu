open Module;
open NodeJs.Process;
module Path = NodeJs.Path;

let cleanFolder = () => {
  Js.Promise.(
    "dist"
    |> Path.join2(cwd(process))
    |> Path.normalize
    |> Fs_Extra.remove
    |> then_(_ => resolve())
    |> catch(err => err |> Console.log |> resolve)
  );
};