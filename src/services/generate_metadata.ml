module Path = NodeJs.Path

type t = {
  templates : string array;
  path : string;
  distPath : string;
  basename : string;
}

let createMetadata (path : string) templates =
  {
    templates;
    path;
    distPath =
      "index.html" |> Path.join2 (Generate_folder.run path) |> Path.normalize;
    basename = Node.Path.basename path;
  }

let run listfiles listTemplates =
  Belt.Array.map listfiles (fun file -> createMetadata file listTemplates)
