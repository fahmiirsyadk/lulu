open Utils
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
  Fs_Extra.pathExists origin
  |> then_ (fun res ->
         if res then Fs_Extra.copy origin destination else () |> resolve)
  |> catch (fun err ->
         errorBanner "Error when trying to copy assets" err |> resolve)
