%
% Copyright 2019 Gianluca Frison, Dimitris Kouzoupis, Robin Verschueren,
% Andrea Zanelli, Niels van Duijkeren, Jonathan Frey, Tommaso Sartor,
% Branimir Novoselnik, Rien Quirynen, Rezart Qelibari, Dang Doan,
% Jonas Koenemann, Yutao Chen, Tobias Schöls, Jonas Schlagenhauf, Moritz Diehl
%
% This file is part of acados.
%
% The 2-Clause BSD License
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.;
%

function render_acados_templates(acados_ocp_nlp_json_file, codegen_dir)

tmp = load('acados_root_dir.mat');
if isempty(tmp)
    error('acados cannot be found on MATLAB path')
else
    acados_root_dir= tmp.root_dir;
end
acados_template_folder = fullfile(acados_root_dir, 'interfaces', ...
    'acados_template', 'acados_template');

% check if t_renderer is available -> download if not
if ispc()
    renderer = fullfile(acados_root_dir, 'bin', 't_renderer.exe');
else
    renderer = fullfile(acados_root_dir, 'bin', 't_renderer');
end

if ~exist(renderer, 'file')
    set_up_t_renderer(renderer)
end

%% load json data
% if is_octave()
acados_ocp = loadjson(fileread(acados_ocp_nlp_json_file));
% else % Matlab
%     acados_ocp = jsondecode(fileread(acados_ocp_nlp_json_file));
% end
% get model name from json file
model_name = acados_ocp.model.name;

%% render templates
template_dir = fullfile(acados_template_folder, 'c_templates_tera', '*');
json_fullfile = acados_ocp_nlp_json_file;
current_dir = pwd();
cd(codegen_dir);

% main
template_file = 'main.in.c';
out_file = ['main_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% main_sim
template_file = 'main_sim.in.c';
out_file = ['main_sim_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% make_main_mex
template_file = 'make_main_mex.in.m';
out_file = ['make_main_mex_', model_name, '.m'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% main for matlab/octave
template_file = 'main_mex.in.c';
out_file = ['main_mex_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% make_mex
template_file = 'make_mex.in.m';
out_file = ['make_mex_', model_name, '.m'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% MEX constructor
template_file = 'acados_mex_create.in.c';
out_file = ['acados_mex_create_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% MEX destructor
template_file = 'acados_mex_free.in.c';
out_file = ['acados_mex_free_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% MEX solve
template_file = 'acados_mex_solve.in.c';
out_file = ['acados_mex_solve_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% MEX set
template_file = 'acados_mex_set.in.c';
out_file = ['acados_mex_set_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% MEX class
template_file = 'mex_solver.in.m';
out_file = [model_name, '_mex_solver.m'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% solver
template_file = 'acados_solver.in.c';
out_file = ['acados_solver_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

template_file = 'acados_solver.in.h';
out_file = ['acados_solver_', model_name, '.h'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% sim_solver
template_file = 'acados_sim_solver.in.c';
out_file = ['acados_sim_solver_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

template_file = 'acados_sim_solver.in.h';
out_file = ['acados_sim_solver_', model_name, '.h'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

template_file = 'acados_sim_solver_sfun.in.c';
out_file = ['acados_sim_solver_sfunction_', model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

template_file = 'make_sfun_sim.in.m';
out_file = 'make_sfun_sim.m';
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% headers and custom C-code files
cd([model_name, '_model']);
template_file = 'model.in.h';
out_file = [model_name, '_model.h'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)
cd(codegen_dir);

cost_dir = [model_name, '_cost'];
if ~(exist(cost_dir, 'dir'))
    mkdir(cost_dir);
end
cd(cost_dir);
if strcmp(acados_ocp.cost.cost_type, 'NONLINEAR_LS')
    template_file = 'cost_y_fun.in.h';
    out_file = [model_name, '_cost_y_fun.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
elseif strcmp(acados_ocp.cost.cost_type, 'EXTERNAL')
    template_file = 'external_cost.in.h';
    out_file = [model_name, '_external_cost.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
if strcmp(acados_ocp.cost.cost_type_0, 'NONLINEAR_LS')
    template_file = 'cost_y_0_fun.in.h';
    out_file = [model_name, '_cost_y_0_fun.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
elseif strcmp(acados_ocp.cost.cost_type_0, 'EXTERNAL')
    template_file = 'external_cost_0.in.h';
    out_file = [model_name, '_external_cost_0.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
if strcmp(acados_ocp.cost.cost_type_e, 'NONLINEAR_LS')
    template_file = 'cost_y_e_fun.in.h';
    out_file = [model_name, '_cost_y_e_fun.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
elseif strcmp(acados_ocp.cost.cost_type_e, 'EXTERNAL')
    template_file = 'external_cost_e.in.h';
    out_file = [model_name, '_external_cost_e.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
cd(codegen_dir);

% constraints
constr_dir = [model_name, '_constraints'];
if ~(exist(constr_dir, 'dir'))
    mkdir(constr_dir);
end
cd(constr_dir)
if (acados_ocp.dims.npd > 0)
    template_file = 'p_constraint.in.h';
    out_file = [model_name, '_p_constraint.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
if (acados_ocp.dims.nh > 0)
    % render source template
    template_file = 'h_constraint.in.h';
    out_file = [model_name, '_h_constraint.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
if (acados_ocp.dims.nh_e > 0)
    % render source template
    template_file = 'h_e_constraint.in.h';
    out_file = [model_name, '_h_e_constraint.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
if (acados_ocp.dims.npd_e > 0)
    template_file = 'p_e_constraint.in.h';
    out_file = [model_name, '_p_e_constraint.h'];
    render_file(json_fullfile, template_dir, template_file, out_file, renderer)
end
cd(codegen_dir);

% Makefile
template_file = 'Makefile.in';
out_file = 'Makefile';
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% S-function
template_file = 'acados_solver_sfun.in.c';
out_file = ['acados_solver_sfunction_' , model_name, '.c'];
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

% MATLAB make script
template_file = 'make_sfun.in.m';
out_file = 'make_sfun.m';
render_file(json_fullfile, template_dir, template_file, out_file, renderer)

fprintf('Successfully rendered acados templates!\n');
cd(current_dir)
end



%% Auxiliary functions
function render_file(json_fullfile, template_dir, template_file, out_file, t_renderer_location)
    os_cmd = [t_renderer_location, ' "', template_dir, '"', ' ', '"', ...
        template_file, '"', ' ', '"', json_fullfile, '"', ' ', '"', ...
        out_file, '"'];

    [status, result] = system(os_cmd);
    if status~=0
        cd('..')
        error(['rendering %s failed.\n command: %s\n returned status ', ...
            '%d, got result:\n%s\n\n'], template_file, os_cmd, status, ...
            result);
    end
    % NOTE: this should return status != 0, maybe fix in tera renderer?
    if ~isempty(strfind(result, 'Error')) % contains not implemented in Octave
        cd ..
        error('rendering %s failed.\n command: %s\n returned status %d, got result: %s',...
            template_file, os_cmd, status, result);
    end
end

function set_up_t_renderer(renderer)
    message = ['\nDear acados user, we could not find t_renderer binaries,',...
        '\n which are needed to export templated C code from ',...
        'Matlab.\n Press any key to proceed setting up the t_renderer automatically.',...
        '\n Press "n" or "N" to exit, if you wish to set up t_renderer yourself.\n',...
        '\n https://github.com/acados/tera_renderer/releases'];

    In = input(message,'s');

    if strcmpi( In, 'n')
        error('Please set up t_renderer yourself and try again');
    else
        t_renderer_version = 'v0.0.34';
        if isunix()
            suffix = '-linux';
        elseif ismac()
            suffix = '-osx';
        elseif ispc()
            suffix = '-windows';
        end
        acados_root_dir = getenv('ACADOS_INSTALL_DIR');

        tera_url = ['https://github.com/acados/tera_renderer/releases/download/', ...
                t_renderer_version '/t_renderer-', t_renderer_version, suffix];
        destination = fullfile(acados_root_dir, 'bin');
        tmp_file = websave(destination, tera_url);

        if ~exist(destination, 'dir')
            [~,~] = mkdir(destination);
        end

        movefile(tmp_file, renderer);

        if isunix() || ismac()
            % make executable
            system(['chmod a+x ', renderer]);
        end
        fprintf('\nSuccessfully set up t_renderer\n')
    end
end
