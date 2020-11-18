%% Simulations
clc
no_scenario = 1;        % No scenario has been assigned yet is true

while no_scenario > 0   % While user hasn't choosen an option
    % Text to user
    fprintf('Enter 1 for three body simulation,\n')
    fprintf('2 for space station simulation,\n')
    fprintf('3 for moon phase simulation and\n')
    fprintf('4 to quit\n\n')
    scenario = input('Enter value here: '); % Assigns user input value to 
                                            % scenario variable.
    if scenario == 1        % Three Body Simulation
        step = 1/10;        % Large step
         N = 11000;         % Enough coordinates for around three years
        Storage = RungeKutta(step, N, InitialConditions);
        Simulation(scenario, step, N, Storage)
        no_scenario = 0;    % User chose a scenario
   
    elseif scenario == 2    % Space Station Simulation
        step = 1/1000;      % Tiny step, around 40 coordinates per hour
        N = 250;            % Enough coordinates for around 4 orbits
        Storage = RungeKutta(step, N, InitialConditions);
        Simulation(scenario, step, N, Storage)
        no_scenario = 0;    % User chose a scenario
        
    elseif scenario == 3    % Moon Phase Simulation
        step = 1/80;        % Medium step, track monthly orbit of Earth
        N = 2400;            % Enough coordinates for around 3 earth orbits
        Storage = RungeKutta(step, N, InitialConditions);
        Simulation(scenario, step, N, Storage)
        no_scenario = 0;    % User chose a scenario
        
    elseif scenario == 4    % User wants to quit 
        break
    
    else                    % An invalid key was entered by user
        clc
        fprintf('You have entered an invalid value, please try again\n\n')
    end
end

%% Animations
clc
no_scenario = 1;        % No scenario has been assigned yet is true

while no_scenario > 0   % While user hasn't choosen an option
    % Text to user
    fprintf('Enter 1 for three body simulation,\n')
    fprintf('2 for space station simulation,\n')
    fprintf('3 for moon phase simulation and\n')
    fprintf('4 to quit\n\n')
    scenario = input('Enter value here: '); % Assigns user input value to 
                                            % scenario variable.

    if scenario == 1        % Three Body Simulation
        step = 1/10;        % Large step
        N = 11000;          % Enough coordinates for around three years
        Animation(scenario, step, N, InitialConditions);
        no_scenario = 0;    % User chose a scenario 
   
    elseif scenario == 2    % Space Station Simulation
        step = 1/1000;      % Tiny step, around 40 coordinates per hour
        N = 250;            % Enough coordinates for around 4 orbits
        Animation(scenario, step, N, InitialConditions);
        no_scenario = 0;    % User chose a scenario
        
    elseif scenario == 3    % Moon Phase Simulation
        step = 1/80;        % Medium step, track monthly orbit of Earth
        N = 2400;            % Enough coordinates for around 3 earth orbits
        Animation(scenario, step, N, InitialConditions);
        no_scenario = 0;    % User chose a scenario
        
    elseif scenario == 4    % User wants to quit 
        break
    
    else                    % An invalid key was entered by user
        clc
        fprintf('You have entered an invalid value, please try again\n\n')
    end
end