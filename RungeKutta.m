function [Storage] = RungeKutta(step, N, Initial_Cond)



% Display error if less than or more than three inputs to function
if nargin<3; error ('Not enough input arguments.'); end 
if nargin>3; error ('Too many input arguments.'); end
 
Storage = zeros(24,N); % Creates storage for 24 position and velocity rows 
                       % and N column steps. 
Storage(:,1)= Initial_Cond; % Writes first initial conditions column, 
                            % so untouched by Runge Kutta loop.
 
%Loop to keep track of Runge-Kutta iterations
for count = 2:N
temp_Cond = Initial_Cond;
k1 = step * (Accelerations(temp_Cond));

temp_Cond = (Initial_Cond + ((1/2)*k1));
k2 = step * (Accelerations(temp_Cond));

temp_Cond = Initial_Cond + ((1/2)*k2);
k3 = step * (Accelerations(temp_Cond));

temp_Cond = Initial_Cond + k3;
k4 = step * (Accelerations(temp_Cond));

Initial_Cond = Initial_Cond + ((1/6) * (k1+(2*k2)+(2*k3)+k4));
%Sets the ouput as the new Initial_Cond Matrix.
Storage(:,count)= Initial_Cond;
end
%--------------------------------------------------------------------------

end