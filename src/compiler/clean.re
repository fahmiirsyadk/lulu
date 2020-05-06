open Module;

let cleanFolder = () => Fs_Extra.remove(normalize({j|cwd/dist|j}));
