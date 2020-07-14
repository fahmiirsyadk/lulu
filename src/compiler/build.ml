open Module
open NodeJs.PerfHooks.Performance

let run () =
  let open Js.Promise in
  let time = now performance in
  Clean.cleanFolder |> resolve
  |> then_ (fun _ ->
         [|
           fsGlob [| Generate_pages.location |];
           fsGlob [| Generate_template.location |];
         |]
         |> all)
  |> then_ (fun res -> Generate_metadata.run res.(0) res.(1) |> resolve)
  |> then_ (fun res ->
         [| Generate_pages.run res; Generate_assets.copyAssets |] |> all)
  |> then_ (fun _ -> time |> logMeasure |> resolve)
