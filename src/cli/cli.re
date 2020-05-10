type sadeType;
[@bs.module] external sade: string => sadeType = "sade";
[@bs.send.pipe: sadeType] external version: float => sadeType = "version";
[@bs.send.pipe: sadeType] external command: string => sadeType = "command";
[@bs.send.pipe: sadeType] external describe: string => sadeType = "describe";
[@bs.send.pipe: sadeType]
external parse: (array('a), Js.t({..})) => sadeType = "parse";
[@bs.send.pipe: sadeType] external example: string => sadeType = "example";
[@bs.send.pipe: sadeType]
external action: (unit => Js.Promise.t('a)) => sadeType = "action";

let prog = sade("lulu") |> version(0.1);

prog
|> command("build")
|> describe("Build the source directory.")
|> example("build")
|> action(() => Js.Promise.(Build.run() |> resolve));

prog
|> command("init")
|> describe("Initialize project files")
|> example("init")
|> action(() => Js.Promise.(Generate.run() |> resolve));

prog
|> parse(
     Node.Process.argv,
     {"unknown": (arg: string) => {j|Uknown option $arg|j}},
   );