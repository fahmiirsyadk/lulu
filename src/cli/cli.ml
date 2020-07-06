type sadeType

external sade : string -> sadeType = "sade" [@@bs.module]

external version : float -> sadeType = "version" [@@bs.send.pipe: sadeType]

external command : string -> sadeType = "command" [@@bs.send.pipe: sadeType]

external describe : string -> sadeType = "describe" [@@bs.send.pipe: sadeType]

external parse : 'a array -> < .. > Js.t -> sadeType = "parse"
  [@@bs.send.pipe: sadeType]

external example : string -> sadeType = "example" [@@bs.send.pipe: sadeType]

external action : (unit -> 'a Js.Promise.t) -> sadeType = "action"
  [@@bs.send.pipe: sadeType]

let prog = sade "lulu" |> version 0.1

let _ =
  prog |> command "build"
  |> describe "Build the source directory."
  |> example "build"
  |> action (fun () ->
         let open Js.Promise in
         Build.run () |> resolve)

let _ =
  prog |> command "init"
  |> describe "Initialize project files"
  |> example "init"
  |> action (fun () ->
         let open Js.Promise in
         Generate.run () |> resolve)

let _ =
  prog
  |> parse Node.Process.argv
       [%bs.obj { unknown = (fun (arg : string) -> {j|Uknown option $arg|j}) }]
