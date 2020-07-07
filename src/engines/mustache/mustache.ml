type mustacheType

external mustache : mustacheType = "mustache" [@@bs.module]

external render : string -> 'a -> mustacheType = "render"
  [@@bs.send.pipe: mustacheType]
