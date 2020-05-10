type error;

[@bs.module]
external glob: (string, (Js.nullable(error), array(string)) => unit) => unit =
  "glob";

type colorsUnit;
[@bs.module] external colors: colorsUnit = "kleur";
[@bs.send.pipe: colorsUnit] external bold: 'a => colorsUnit = "bold";
[@bs.send.pipe: colorsUnit] external green: 'a => colorsUnit = "green";
[@bs.send.pipe: colorsUnit] external underline: 'a => colorsUnit = "underline";

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

let logMeasure = (result: float): unit => {
  let str = (result |> int_of_float |> string_of_int) ++ " mseconds";
  Console.log3(
    colors |> bold() |> green(">>>>"),
    colors |> bold("finish building"),
    colors |> bold() |> green() |> underline(str),
  );
};

let getGlob = (pattern: string) =>
  Js.Promise.make((~resolve, ~reject as _) => {
    glob(pattern, (_, file) => resolve(. file))
  });