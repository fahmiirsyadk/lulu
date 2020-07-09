open Module
open NodeJs.Process
module Path = NodeJs.Path

let getAssets =
  Fs_Extra.pathExists (Path.join2 (cwd process) "assets" |> Path.normalize)

let copyAssets =
  let origin = [| cwd process; "assets" |] |> Path.join |> Path.normalize in
  let destination =
    [| cwd process; "dist"; "assets" |] |> Path.join |> Path.normalize
  in
  let open Js.Promise in
  Fs_Extra.copy origin destination
  |> catch (fun err -> err |> Console.log |> resolve)
