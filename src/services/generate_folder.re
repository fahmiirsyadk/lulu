open Module;

let run = (filename: string) => {
  let filenoExtn = () =>
    Js.String.replace(extname(filename), "", Node.Path.basename(filename));
  Node.Path.join([|
    cwd,
    "dist",
    filenoExtn() === "index" ? "" : filenoExtn(),
  |])
  |> normalize;
};