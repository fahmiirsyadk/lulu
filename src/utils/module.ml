type error

external glob : string -> (error Js.nullable -> string array -> unit) -> unit
  = "glob"
  [@@bs.module]

type colorsUnit

external colors : colorsUnit = "kleur" [@@bs.module]

external bold : 'a -> colorsUnit = "bold" [@@bs.send.pipe: colorsUnit]

external red : 'a -> colorsUnit = "red" [@@bs.send.pipe: colorsUnit]

external green : 'a -> colorsUnit = "green" [@@bs.send.pipe: colorsUnit]

external underline : 'a -> colorsUnit = "underline" [@@bs.send.pipe: colorsUnit]

module Console = Js.Console

module Fs_Extra = struct
  external pathExists : string -> bool Js.Promise.t = "pathExists"
    [@@bs.module "fs-extra"]

  external remove : string -> unit Js.Promise.t = "remove"
    [@@bs.module "fs-extra"]

  external removeSync : string -> unit = "removeSync" [@@bs.module "fs-extra"]

  external outputFile : string -> string -> unit Js.Promise.t = "outputFile"
    [@@bs.module "fs-extra"]

  external readFile : string -> string -> 'a Js.Promise.t = "readFile"
    [@@bs.module "fs-extra"]

  external copy : string -> string -> unit Js.Promise.t = "copy"
    [@@bs.module "fs-extra"]

  external ensureDir : string -> unit Js.Promise.t = "ensureDir"
    [@@bs.module "fs-extra"]

  external copySync : string -> string -> unit = "copySync"
    [@@bs.module "fs-extra"]
end

let logMeasure (result : float) =
  ( let str = (result |> int_of_float |> string_of_int) ^ " mseconds" in
    Console.log3
      (colors |> bold () |> green ">>>>")
      (colors |> bold "finish building")
      (colors |> bold () |> green () |> underline str)
    : unit )

let getGlob (pattern : string) =
  Js.Promise.make (fun ~resolve ~reject:_ ->
      glob pattern (fun _ file -> (resolve file [@bs])))

let errorBanner banner err =
  Console.log2
    ( colors |> bold ()
    |> red (">>>" ^ {j| 😱 |j} ^ banner ^ " with message: \n") )
    err;
  Console.log (colors |> bold () |> red ">>>> End line of error message \n")
