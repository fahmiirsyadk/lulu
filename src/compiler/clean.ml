open Module
open NodeJs.Process
module Path = NodeJs.Path

let cleanFolder () =
  let open Js.Promise in
  "dist"
  |> Path.join2 (cwd process)
  |> Path.normalize |> Fs_Extra.remove
  |> then_ (fun _ -> resolve ())
  |> catch (fun err -> err |> Console.log |> resolve)