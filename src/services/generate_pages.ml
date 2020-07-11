open Module
open NodeJs.Process
module Path = NodeJs.Path

let getPages (pattern : string) = getGlob pattern

type dataTemplate = {
  status : bool;
  meta : Generate_metadata.t;
  page : string;
  content : Md.t;
}

let getDefaultTemplate =
  {j|
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ matter.title }}</title>
</head>
<body>
  {{ children }}
</body>
</html>
|j}

let createPages (meta : Generate_metadata.t) page (content : Md.t) =
  let open Js.Promise in
  Configure_config.getConfig
  |> then_ (fun res ->
         Liquid.compile page
           [%bs.obj
             {
               matter = content.data.matter;
               children = content.children;
               site = res;
             }])
  |> then_ (fun res -> Fs_Extra.outputFile meta.distPath res)
  |> catch (fun err ->
         errorBanner "Error when trying to create page" err |> resolve)

let selectTemplate (pages : string array) (meta : Generate_metadata.t)
    (content : Md.t) =
  let open Js.Promise in
  Belt.Array.map pages (fun page ->
      let pageFilter = Node.Path.basename page in
      let templateName = function None -> "default" | Some x -> x in
      match
        pageFilter = templateName content.data.matter.template ^ ".html"
      with
      | true ->
          Fs_Extra.readFile page "utf-8"
          |> then_ (fun res -> createPages meta res content)
      | false -> createPages meta getDefaultTemplate content)

let compilePages pages =
  let open Js.Promise in
  Fs_Extra.ensureDir ([| cwd process; "dist" |] |> Path.join |> Path.normalize)
  |> then_ (fun _ -> getPages "templates/*.html")
  |> then_ (fun x ->
         Belt.Array.map pages (fun page ->
             let content, meta = page in
             selectTemplate x meta content |> resolve)
         |> all)

let run pages =
  let open Js.Promise in
  Md.getMdFiles pages
  |> then_ (fun x -> compilePages x)
  |> then_ (fun _ -> resolve ())
