module Path = NodeJs.Path;

let run = (filename: string) => {
  let filenoExtn =
    Js.String.replace(
      Path.extname(filename),
      "",
      Node.Path.basename(filename),
    );
  Path.join([|
    Node.Process.cwd(),
    "dist",
    filenoExtn === "index" ? "" : filenoExtn,
  |])
  |> Path.normalize;
};