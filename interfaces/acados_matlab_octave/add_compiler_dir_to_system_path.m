function add_compiler_dir_to_system_path()
compiler_config = mex.getCompilerConfigurations('C');
compiler_dir = fullfile(compiler_config.Location, 'bin');
if ispc()==true
    % Windows
    sys_path = getenv('PATH');
    if contains(sys_path, compiler_dir, 'IgnoreCase', ispc())==false
        setenv('PATH', [sys_path, pathsep, compiler_dir]);
    end
else
    warning(['acados requires a working c compiler on your system ', ...
        'path. Autodetection not tested on linux']);
end
end
