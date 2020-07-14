open Module
open Yaml

let getConfig =
  let open Js.Promise in
  Fs_Extra.pathExists "lulu.config.yml"
  |> then_ (fun res ->
         if res then
           Module.Fs_Extra.readFile "lulu.config.yml" "utf-8"
           |> then_ (fun file -> yaml |> safeLoad file |> resolve)
         else None |> resolve)
  |> catch (fun err ->
         errorBanner "Error when trying to get config" err;
         None |> resolve)
