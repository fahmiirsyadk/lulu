[@bs.val] external require: string => Js.t('a) = "require";
[@bs.module "path"] external normalize: string => string = "normalize";
[@bs.module] external glob: string => Js.Promise.t('a) = "glob";

module Console = Js.Console;

let cwd = Node.Process.cwd();

module Fs_Extra = {
  [@bs.module "fs-extra"] external pathExists: string => Js.Promise.t(bool) = "pathExists";
  [@bs.module "fs-extra"] external remove: string => Js.Promise.t(unit) = "remove";
  [@bs.module "fs-extra"] external outputFile: (string, string) => Js.Promise.t(unit) = "outputFile";
};

let getGlob = (pattern: string) => Js.Promise.(glob(pattern) |> then_(files => files |> resolve) |> catch(err => Console.log(err) |> resolve))
