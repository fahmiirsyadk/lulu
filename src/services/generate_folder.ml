open NodeJs.Process
module Path = NodeJs.Path

let run (filename : string) =
  let filenoExtn =
    Js.String.replace (Path.extname filename) "" (Node.Path.basename filename)
  in
  Path.join
    [|
      cwd process;
      "dist";
      (match filenoExtn == "index" with true -> "" | false -> filenoExtn);
    |]
  |> Path.normalize
