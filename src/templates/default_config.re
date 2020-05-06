open Module;

let filename = "lulu_config.bs.js";
let cwd = Node.Process.cwd();

let getConfig = () => {
  Js.Promise.(Fs_Extra.pathExists(normalize({j|$cwd/$filename|j})) |> resolve);
};

getConfig();