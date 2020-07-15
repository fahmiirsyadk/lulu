type liquidType

type liquidOpt = { root : string array; extname : string }

external liquid : liquidOpt -> liquidType = "Liquid"
  [@@bs.module "liquidjs"] [@@bs.new]

external parse : string -> liquidType = "parse" [@@bs.send.pipe: liquidType]

external render : 'a -> 'b -> string Js.Promise.t = "render"
  [@@bs.send.pipe: liquidType]

let compile template data =
  let engine =
    liquid { root = [| "templates/"; "partials/" |]; extname = ".html" }
  in
  let parsed = engine |> parse template in
  engine |> render parsed data
