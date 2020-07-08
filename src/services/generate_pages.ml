open Module

let getPages (pattern : string) = getGlob pattern

let compileTemplate (content : Md.t) (metadata : Generate_metadata.t) =
  let open Js.Promise in
  getPages "src/layouts/index.html"
  |> then_ (fun res -> Fs_Extra.readFile res.(0) "utf-8")
  |> then_ (fun res ->
         Mustache.compile res [%bs.obj { children = content.children }]
         |> resolve)
  |> then_ (fun res -> Fs_Extra.outputFile metadata.distPath res |> resolve)

let run pages =
  let open Js.Promise in
  Md.getMdFiles pages
  |> then_ (fun x ->
         Belt.Array.map x (fun partial ->
             let content, meta = partial in
             compileTemplate content meta)
         |> resolve)
