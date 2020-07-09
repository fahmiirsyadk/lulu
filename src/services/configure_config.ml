type yamlType

external yaml : yamlType = "js-yaml" [@@bs.module]

external safeLoad : 'a -> yamlType = "safeLoad" [@@bs.send.pipe: yamlType]

let getConfig = yaml |> safeLoad (Node.Fs.readFileSync "lulu.config.yml" `utf8)

let () = Js.log getConfig
