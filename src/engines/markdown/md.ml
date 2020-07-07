open Module

type file = {
  history : string array;
  _contents : string; [@bs.as "contents"]
  data : < > Js.t;
}

type unifiedType

external unified : unit -> unifiedType = "unified" [@@bs.module]

external use : unifiedType -> unifiedType = "use" [@@bs.send.pipe: unifiedType]

external process : 'a Js.Promise.t -> file = "process"
  [@@bs.send.pipe: unifiedType]

external guide : unifiedType = "remark-preset-lint-markdown-style-guide"
  [@@bs.module]

external html : unifiedType = "rehype-stringify" [@@bs.module]

external markdown : unifiedType = "remark-parse" [@@bs.module]

external report : 'a array -> 'a = "vfile-reporter-pretty" [@@bs.module]

external format : unifiedType = "rehype-format" [@@bs.module]

external doc : unifiedType = "rehype-document" [@@bs.module]

external remark2hype : unifiedType = "remark-rehype" [@@bs.module]

external matter : string -> < .. > Js.t -> 'a = "vfile-matter" [@@bs.module]

external read : string -> 'a Js.Promise.t = "read" [@@bs.module "to-vfile"]

let matterAsync file =
  let open Js.Promise in
  matter file [%bs.obj { strip = true }] |> resolve

let generate (filepath : Generate_metadata.t) =
  let open Js.Promise in
  read filepath.path
  |> then_ (fun file -> matterAsync file)
  |> then_ (fun file ->
         unified () |> use markdown |> use guide |> use remark2hype |> use doc
         |> use format |> use html |> process file |> resolve)
  |> then_ (fun file ->
         ( Console.error (report [| file |]);
           file._contents )
         |> resolve)
  |> then_ (fun ctx -> Fs_Extra.outputFile filepath.distPath ctx |> resolve)

let getMdFiles (files : Generate_metadata.t array) =
  let open Js.Promise in
  Belt.Array.map files (fun file -> generate file)
  |> all
  |> then_ (fun _ -> resolve ())
