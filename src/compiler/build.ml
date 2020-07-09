open Module
open NodeJs.PerfHooks.Performance

let getPages (pattern : string) = getGlob pattern

let run () =
  let time = now performance in
  let _ = Clean.cleanFolder in
  let open Js.Promise in
  getPages "src/pages/**/*.md"
  |> then_ (fun res -> Generate_metadata.run res |> resolve)
  |> then_ (fun res -> Generate_pages.run res)
  |> then_ (fun _ -> Generate_assets.copyAssets)
  |> then_ (fun _ -> now performance -. time |> logMeasure |> resolve)
