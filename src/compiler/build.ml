open Module
open NodeJs.PerfHooks.Performance

let getPages (pattern : string) = getGlob pattern

let run () =
  let time = now performance in
  let open Js.Promise in
  Clean.cleanFolder ()
  |> then_ (fun _ ->
         [| getPages "src/pages/**/*.bs.js"; getPages "src/pages/**/*.md" |]
         |> all
         |> then_ (fun res -> res.(1) |> resolve)
         |> then_ (fun res -> Generate_metadata.run res |> resolve)
         |> then_ (fun res -> Md.getMdFiles res |> resolve)
         |> then_ (fun _ -> now performance -. time |> logMeasure |> resolve))
