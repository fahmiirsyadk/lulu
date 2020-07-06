module Path = NodeJs.Path

type t = {
  path : string;
  distPath : string;
  ext : string;
  filename : string;
  basename : string;
}

let createMetadata (path : string) =
  {
    path;
    distPath =
      path
      |> Js.String.replace (Node.Path.basename path) "index.html"
      |> Js.String.replace
           (Path.join [| "src"; "pages" |] |> Path.normalize)
           (Generate_folder.run path);
    ext = Path.extname path;
    filename = Generate_folder.run path;
    basename = Node.Path.basename path;
  }

let run (listfiles : string array) =
  Belt.Array.map listfiles (fun file -> createMetadata file)
