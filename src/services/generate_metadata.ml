module Path = NodeJs.Path

type t = { path : string; distPath : string; ext : string; basename : string }

let createMetadata (path : string) =
  {
    path;
    ext = Path.extname path;
    distPath =
      "index.html" |> Path.join2 (Generate_folder.run path) |> Path.normalize;
    basename = Node.Path.basename path;
  }

let run (listfiles : string array) =
  Belt.Array.map listfiles (fun file -> createMetadata file)
