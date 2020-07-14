open Module
open NodeJs
open Yaml

let createCache pages assets =
  let format = {j|
pages: $pages
assets: $assets  
  |j} in
  Fs_Extra.outputFile
    ( [| Process.cwd Process.process; "dist"; "__cache__.yml" |]
    |> Path.join |> Path.normalize )
    format

let checkCache =
  [| Process.cwd Process.process; "__cache__.yml" |]
  |> Path.join |> Path.normalize |> NodeJs.Fs.existsSync

let getCache = yaml |> safeLoad (Node.Fs.readFileSync "__cache__.yml" `utf8)
