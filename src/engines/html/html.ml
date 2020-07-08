type unifiedType

type t = {
  history : string array;
  children : string; [@bs.as "contents"]
  data : < > Js.t;
}

external unified : unit -> unifiedType = "unified" [@@bs.module]

external parse : unifiedType = "parse" [@@bs.module "rehype-parse"]

external use : unifiedType -> unifiedType = "use" [@@bs.send.pipe: unifiedType]

external read : string -> 'a Js.Promise.t = "read" [@@bs.module "to-vfile"]

external process : 'a Js.Promise.t -> t = "process"
  [@@bs.send.pipe: unifiedType]
