open Module

type unifiedType

type matter = { template : string option }

type data = { matter : matter }

type t = {
  history : string array;
  children : string; [@bs.as "contents"]
  data : data;
}

external unified : unit -> unifiedType = "unified" [@@bs.module]

external use : unifiedType -> unifiedType = "use" [@@bs.send.pipe: unifiedType]

external process : 'a Js.Promise.t -> t = "process"
  [@@bs.send.pipe: unifiedType]

external guide : unifiedType = "remark-preset-lint-markdown-style-guide"
  [@@bs.module]

external html : unifiedType = "rehype-stringify" [@@bs.module]

external markdown : unifiedType = "remark-parse" [@@bs.module]

external report : 'a -> 'a = "vfile-reporter" [@@bs.module]

external remark2hype : unifiedType = "remark-rehype" [@@bs.module]

external matter : string -> < .. > Js.t -> 'a = "vfile-matter" [@@bs.module]

external read : string -> 'a Js.Promise.t = "read" [@@bs.module "to-vfile"]

let matterAsync file =
  let open Js.Promise in
  matter file [%bs.obj { strip = true }] |> resolve

let compileMd file =
  unified () |> use markdown |> use guide |> use remark2hype |> use html
  |> process file

let compileMdNoLinter file =
  unified () |> use markdown |> use remark2hype |> use html |> process file

let processMd data file =
  match data with
  | Some data ->
      if data##lulu##markdown##linter then compileMd file
      else compileMdNoLinter file
  | None ->
      unified () |> use markdown |> use guide |> use remark2hype |> use html
      |> process file

let parse (filepath : Generate_metadata.t) =
  let open Js.Promise in
  read filepath.path
  |> then_ (fun file -> matterAsync file)
  |> then_ (fun file ->
         Configure_config.getConfig
         |> then_ (fun config -> (config, file) |> resolve))
  |> then_ (fun data ->
         let config, file = data in
         processMd config file |> resolve)
  |> then_ (fun file ->
         Configure_config.getConfig
         |> then_ (fun config ->
                match config with
                | Some data ->
                    if data##lulu##silent then () |> resolve
                    else Console.log (report file) |> resolve
                | None -> Console.log (report file) |> resolve)
         |> then_ (fun _ -> (file, filepath) |> resolve))

let getMdFiles (files : Generate_metadata.t array) =
  let open Js.Promise in
  Belt.Array.map files (fun file -> parse file)
  |> all
  |> then_ (fun res -> res |> resolve)
