function y = model_eval(params)
    % tspan is a vector of time points at which to evaluate the solution
    % params is a vector of parameter values
    % t is a vector of time points on output (same as tspan if
    %       length(tspan) > 2.
    % y = [R, RL, G, Ga] is a matrix of output at the times in the vector
    %       t.
    
    global L T
    
    % Varying parameters
    kGa = 10^params(1);
    kGd = 10^params(2);
    
    % Fixed parameters
    kRL = 2*1e-3;
    kRLm = 1e-2;
    kRs = 4;
    kRd0 = 4*1e-4;
    kRd1 = 4*1e-3;
    kG1 = 1;
    Gt = 1e4;
    Rt = 1e4;
    
    y0 = [Rt; 0; Gt; 0]; % initial conditions
    
    tspan = [0 T];
    
    odefun = @(t,y) [-kRL*L*y(1) + kRLm*y(2) - kRd0*y(1) + kRs;
        kRL*L*y(1) - kRLm*y(2) - kRd1*y(2);
        -kGa*y(2)*y(3) + kG1*max(Gt-y(3)-y(4),0)*max(Gt-y(3),0);
        kGa*y(2)*y(3) - kGd*y(4)];
    
    % Solve ODE
    [~,y1] = ode23s(odefun,tspan,y0);
    yvec = y1(end,:);
    
    Gt = 1e4;
    Gbg = Gt-yvec(3);
    y = Gbg/Gt;
end