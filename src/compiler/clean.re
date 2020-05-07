open Module;

let cleanFolder = () =>
  Js.Promise.(
    Fs_Extra.remove(normalize({j|cwd/dist|j}))
    |> then_(_ => resolve())
    |> catch(err => err |> Console.log |> resolve)
  );