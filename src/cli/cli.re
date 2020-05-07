open Module;

[@bs.module] external sade: string => 'a = "sade";
[@bs.module] external colors: 'a = "kleur";

let prog = sade("lulu")##version(0.1);

if (Node.Process.argv[2] == "start") {
  Console.error(colors##bold()##red("its kinda error bruh..."));
  Node.Process.exit(1);
};

let start = Js.Date.now();

// TODO: eject data ?
prog##command("eject")##describe("Copy out fallback files")##action(() => {
  Js.Promise.(
    require("./eject.bs.js")
    |> resolve
    |> then_(data => data##eject() |> resolve)
  )
});

prog##command("build")##describe("Build the source directory.")##example(
  "build",
)##action(
  () =>
  Js.Promise.(Build.run() |> resolve)
);

prog##command("init")##describe("Initialize project files")##example("init")##action(
  () => {
  Js.Promise.(Generate.run() |> resolve)
});

prog##parse(
  Node.Process.argv,
  {"unknown": (arg: string) => {j|Uknown option $arg|j}},
);