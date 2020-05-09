type error;

[@bs.module]
external glob: (string, (Js.nullable(error), array(string)) => unit) => unit =
  "glob";
[@bs.module] external sade: string => 'a = "sade";
[@bs.module] external colors: Js.t({..}) = "kleur";

module Console = Js.Console;

module Fs_Extra = {
  [@bs.module "fs-extra"]
  external pathExists: string => Js.Promise.t(bool) = "pathExists";
  [@bs.module "fs-extra"]
  external remove: string => Js.Promise.t(unit) = "remove";
  [@bs.module "fs-extra"]
  external outputFile: (string, string) => Js.Promise.t(unit) = "outputFile";
  [@bs.module "fs-extra"]
  external readFile: (string, string) => Js.Promise.t('a) = "readFile";
  [@bs.module "fs-extra"]
  external copy: (string, string) => Js.Promise.t(unit) = "copy";
};

let logMeasure = (result: float) =>
  Console.log3(
    colors##bold()##green(">>>"),
    colors##bold("Finish building:"),
    colors##bold()##green()##underline(
      (result |> int_of_float |> string_of_int) ++ " mseconds",
    ),
  );

let getGlob = (pattern: string) =>
  Js.Promise.make((~resolve, ~reject as _) => {
    glob(pattern, (_, file) => resolve(. file))
  });