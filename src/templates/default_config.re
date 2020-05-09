open Module;
module Path = NodeJs.Path;

let filename = "lulu_config.bs.js";

let getConfig = () => {
  Js.Promise.(
    filename
    |> Path.join2(Node.Process.cwd())
    |> Path.normalize
    |> Fs_Extra.pathExists
    |> resolve
  );
};

getConfig();