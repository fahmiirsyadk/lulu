open Module

let run () =
  Js.Console.timeStart "Build time";
  let open Js.Promise in
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
  |> then_ (fun _ -> Js.Console.timeEnd "Build time" |> resolve)
