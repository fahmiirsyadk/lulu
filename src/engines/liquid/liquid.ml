type liquidType

external liquid : unit -> liquidType = "Liquid"
  [@@bs.module "liquidjs"] [@@bs.new]

external parse : string -> liquidType = "parse" [@@bs.send.pipe: liquidType]

external render : 'a -> 'b -> string Js.Promise.t = "render"
  [@@bs.send.pipe: liquidType]

let compile template data =
  let engine = liquid () in
  let parsed = engine |> parse template in
  engine |> render parsed data
