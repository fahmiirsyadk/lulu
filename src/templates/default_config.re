open Module;
open NodeJs;
open Process;
module Path = NodeJs.Path;

let filename = "lulu_config.bs.js";

let getConfig = () => {
  Js.Promise.(
    filename
    |> Path.join2(cwd(process))
    |> Path.normalize
    |> Fs_Extra.pathExists
    |> resolve
  );
};

getConfig();