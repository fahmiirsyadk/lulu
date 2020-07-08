open Module
open NodeJs.PerfHooks.Performance

let getPages (pattern : string) = getGlob pattern

let run () =
  let time = now performance in
  let open Js.Promise in
  Clean.cleanFolder ()
  |> then_ (fun _ ->
         getPages "src/pages/**/*.md"
         |> then_ (fun res -> res |> resolve)
         |> then_ (fun res -> Generate_metadata.run res |> resolve)
         |> then_ (fun res -> Generate_pages.run res |> resolve)
         |> then_ (fun _ -> now performance -. time |> logMeasure |> resolve))
