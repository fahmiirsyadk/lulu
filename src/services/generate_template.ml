open NodeJs

let location =
  [| Process.cwd Process.process; "templates"; "*.html" |]
  |> Path.join |> Path.normalize
