open Module;
module Path = NodeJs.Path;

let cleanFolder = () => {
  Js.Promise.(
    Path.join2(Node.Process.cwd(), "dist")
    |> Path.normalize
    |> Fs_Extra.remove
    |> then_(_ => resolve())
    |> catch(err => err |> Console.log |> resolve)
  );
};