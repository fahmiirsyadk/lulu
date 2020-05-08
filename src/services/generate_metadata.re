open Module;

type t = {
  path: string,
  distPath: string,
  ext: string,
  filename: string,
  basename: string,
};

let createMetadata = (path: string) => {
  path,
  distPath:
    path
    |> Js.String.replace(Node.Path.basename(path), "index.html", _)
    |> Js.String.replace(
         Node.Path.join([|"src", "pages"|]) |> normalize,
         Generate_folder.run(path),
         _,
       ),
  ext: extname(path),
  filename: Generate_folder.run(path),
  basename: Node.Path.basename(path),
};

let run = (listfiles: array(string)) =>
  Belt.Array.map(listfiles, file => createMetadata(file));