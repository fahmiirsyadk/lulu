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

(* let engine = liquid ()

let tpl = engine |> parse "Welcome to {{v}}!"

let data =
  let _ =
    let open Js.Promise in
    engine
    |> render tpl [%bs.obj { v = "Liquid Lulu" }]
    |> then_ (fun res -> Js.log res |> resolve)
  in
  ()

let _ = data *)
