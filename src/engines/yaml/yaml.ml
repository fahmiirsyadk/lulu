type yamlType

external yaml : yamlType = "js-yaml" [@@bs.module]

external safeLoad : 'a -> 'b option = "safeLoad" [@@bs.send.pipe: yamlType]
