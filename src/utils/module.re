type error;

[@bs.val] external require: string => Js.t('a) = "require";
[@bs.module "path"] external normalize: string => string = "normalize";
[@bs.module]
external glob: (string, (Js.nullable(error), array(string)) => unit) => unit =
  "glob";
[@bs.module "perf_hooks"] [@bs.scope "performance"]
external now: unit => int = "now";
[@bs.module] external sade: string => 'a = "sade";
[@bs.module] external colors: Js.t({..}) = "kleur";

module Console = Js.Console;

let cwd = Node.Process.cwd();

module Fs_Extra = {
  [@bs.module "fs-extra"]
  external pathExists: string => Js.Promise.t(bool) = "pathExists";
  [@bs.module "fs-extra"]
  external remove: string => Js.Promise.t(unit) = "remove";
  [@bs.module "fs-extra"]
  external outputFile: (string, string) => Js.Promise.t(unit) = "outputFile";
  [@bs.module "fs-extra"]
  external readFile: (string, string) => Js.Promise.t('a) = "readFile";
};

let logMeasure = (result: int) =>
  Console.log2(
    colors##bold("time elapsed:"),
    colors##bold()##green()##underline({j|$result miliseconds.|j}),
  );

let getGlob = (pattern: string) =>
  Js.Promise.make((~resolve, ~reject as _) => {
    glob(pattern, (_, file) => resolve(. file))
  });