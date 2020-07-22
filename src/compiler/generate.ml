open Module
open NodeJs
open Process
open PerfHooks.Performance

let run () =
  let time = now performance in
  let _ =
    [| cwd process; "pages"; "index.md" |]
    |> Path.join |> Path.normalize |. Fs_Extra.outputFileSync ""
  in
  time |> logMeasure
