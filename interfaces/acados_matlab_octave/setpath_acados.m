function include_paths = setpath_acados(is_submodule)
% 
%   Signature   : include_paths = setpath_acados(is_submodule)
%
%   Description : Sets/ removes all necessary paths for project.
%                 1. If project is used as a submodule within another
%                    project, only pass forward the paths to include
%                 2. Checks if a file with include paths already exists in
%                    the temp folder. If not, the last session was ended 
%                    properly and the environment was closed. In this case,
%                    set the environment.
%                 3. Otherwise or Matlab was closed without closing the 
%                    environemnt (the process id will be different) or the
%                    environment is supposed to be closed. In the first 
%                    case, set environment normally. In the latter case 
%                    clear path.
%
%   Parameters  : is_submodule -> Boolean controlling whether to forward
%                                include paths to calling function
%
%   Return      : -
%
%-------------------------------------------------------------------------%

% Specify required matlab paths
root_dir = fullfile(fileparts(mfilename('fullpath')), '..', '..');
interface_matlab_dir = fileparts(mfilename('fullpath'));
include_paths = { ...
    root_dir; ...
    fullfile(root_dir, 'bin'); ...
    fullfile(root_dir, 'lib'); ...
    fullfile(root_dir, 'external'); ...
    fullfile(root_dir, 'external', 'jsonlab'); ...
    interface_matlab_dir; ...
    fullfile(interface_matlab_dir, '..'); ...
    fullfile(interface_matlab_dir, 'acados_sim'); ...
    fullfile(interface_matlab_dir, 'acados_ocp'); ...
    fullfile(interface_matlab_dir, 'gnsf'), ...
};

% Determine action
temp_folder = fullfile(root_dir, 'temp');
if nargin > 0 && is_submodule > 0
    do = 'forward';
elseif ~isfile([temp_folder, filesep, 'include_paths.mat'])
    do = 'open';
else
    stored_info = load([temp_folder, filesep, 'include_paths.mat'], ...
        'include_paths', 'current_pid');
    if stored_info.current_pid == feature('getpid')
        do = 'close';
    else
        do = 'open';
    end
end

switch do
    case 'forward'
        
    case 'open'
        % Store root dir
        save('acados_root_dir', 'root_dir');
        
        % Add specified folders to matlab path
        for ii = 1:size(include_paths, 1)
            addpath(include_paths{ii});
        end
        
        % Set work directory for compiled and temporary data
        if ~isfolder(temp_folder)
            mkdir(temp_folder)
        end
        Simulink.fileGenControl('set', 'CacheFolder', temp_folder, ...
            'CodeGenFolder', temp_folder);
        
        % Store path arrays and current process ID
        current_pid = feature('getpid');
        save([temp_folder, filesep, 'include_paths.mat'], ...
            'include_paths', 'current_pid');
        
    case 'close'
        for ii = 1:size(stored_info.include_paths, 1)
            rmpath(stored_info.include_paths{ii});
        end
        delete(fullfile(temp_folder, 'include_paths.mat'))
        delete([interface_matlab_dir, filesep, 'acados_root_dir.mat'])
end
end
