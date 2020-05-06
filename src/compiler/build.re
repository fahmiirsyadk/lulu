open Module;

let getPages = (pattern: string) => getGlob(pattern);

let run = () => {
  Console.log("Deleting earlier folder...");
  Js.Promise.(Clean.cleanFolder() |> then_(_ => [|getPages("src/pages/**/*.bs.js"),getPages("src/pages/**/*.md")|] |> all |> then_(_ => Console.log("done") |> resolve)));
};