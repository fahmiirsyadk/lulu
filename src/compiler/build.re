open Module;

let getPages = (pattern: string) => getGlob(pattern);

let run = () => {
  let time = now();
  Js.Promise.(
    Clean.cleanFolder()
    |> then_(_ =>
         [|getPages("src/pages/**/*.bs.js"), getPages("src/pages/**/*.md")|]
         |> all
         |> then_(res => Console.log(res) |> resolve)
         |> then_(_ => now() - time |> logMeasure |> resolve)
       )
  );
};