open Module;
open NodeJs;
open Process;
open Global;
open PerfHooks.Performance;

let absPath = (path: string) => Path.resolve([|dirname, path|]);

let run = () => {
  let time = now(performance);
  Js.Promise.(
    [|cwd(process), "src", "pages"|]
    |> Path.join
    |> Path.normalize
    |> Fs_Extra.copy(absPath({j|../templates/pages|j}) |> Path.normalize)
    |> then_(_ => now(performance) -. time |> logMeasure |> resolve)
  );
};