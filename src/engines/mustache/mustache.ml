type mustacheType

external mustache : mustacheType = "mustache" [@@bs.module]

external render : string -> 'a -> string = "render"
  [@@bs.send.pipe: mustacheType]

let compile template data = mustache |> render template data
