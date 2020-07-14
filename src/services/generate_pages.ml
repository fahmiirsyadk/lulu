open Module
open NodeJs

let createPages (meta : Generate_metadata.t) template (content : Md.t) =
  let open Js.Promise in
  Configure_config.getConfig
  |> then_ (fun res ->
         Liquid.compile template
           [%bs.obj
             {
               matter = content.data.matter;
               children = content.children;
               site = res;
             }])
  |> then_ (fun res -> Fs_Extra.outputFile meta.distPath res)
  |> catch (fun err ->
         errorBanner "Error when trying to create page" err |> resolve)

let selectTemplate (data : (Md.t * Generate_metadata.t) array) =
  let open Js.Promise in
  Belt.Array.map data (fun ctx ->
      let md, meta = ctx in
      Belt.Array.map meta.templates (fun template ->
          let basenameTemplate = Path.basenameExt template ".html" in
          let templateMatter = function None -> "default" | Some x -> x in
          match basenameTemplate = templateMatter md.data.matter.template with
          | true ->
              Fs_Extra.readFile template "utf-8"
              |> then_ (fun res -> createPages meta res md)
          | false -> createPages meta Default_template.get md))

let run (data : Generate_metadata.t array) =
  let open Js.Promise in
  Md.getMdFiles data
  |> then_ (fun res -> selectTemplate res |> resolve)
  |> then_ (fun _ -> resolve ())

let location =
  [| Process.cwd Process.process; "pages"; "**"; "*.md" |]
  |> Path.join |> Path.normalize
