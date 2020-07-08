open Module

let getPages (pattern : string) = getGlob pattern

type dataTemplate = {
  status : bool;
  meta : Generate_metadata.t;
  page : string;
  content : Md.t;
}

let createPages template =
  let open Js.Promise in
  match template.status with
  | true ->
      Fs_Extra.readFile template.page "utf-8"
      |> then_ (fun res ->
             Mustache.compile res
               [%bs.obj
                 {
                   matter = template.content.data.matter;
                   children = template.content.children;
                 }]
             |> resolve)
      |> then_ (fun res -> Fs_Extra.outputFile template.meta.distPath res)
  | false -> () |> resolve

let selectTemplate (pages : string array) (meta : Generate_metadata.t)
    (content : Md.t) =
  let open Js.Promise in
  Belt.Array.map pages (fun page ->
      let pageFilter = Node.Path.basename page in
      let templateName = function None -> "index" | Some x -> x in
      let templateRes =
        if pageFilter = templateName content.data.matter.template ^ ".html" then
          { status = true; meta; page; content }
        else { status = false; meta; page; content }
      in
      createPages templateRes)
  |> resolve

let compileTemplate (content : Md.t) (metadata : Generate_metadata.t) =
  let open Js.Promise in
  getPages "src/templates/*.html"
  |> then_ (fun pages -> selectTemplate pages metadata content |> resolve)

let run pages =
  let open Js.Promise in
  Md.getMdFiles pages
  |> then_ (fun x ->
         Belt.Array.map x (fun partial ->
             let content, meta = partial in
             compileTemplate content meta)
         |> resolve)
