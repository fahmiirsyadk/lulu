[@bs.val] external require: string => Js.t('a) = "require";
[@bs.module "path"] external normalize: string => string = "normalize";

module Console = Js.Console;

let cwd = Node.Process.cwd();

module Fs_Extra = {
  [@bs.module] external fs: 'a = "fs-extra";
  [@bs.module "fs-extra"] external pathExists: string => Js.Promise.t(bool) = "pathExists";
  [@bs.module "fs-extra"] external remove: string => Js.Promise.t(unit) = "remove";
};