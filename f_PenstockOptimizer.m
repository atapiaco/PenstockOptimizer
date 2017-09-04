function [ results, tiempo, penstock ] = f_PenstockOptimizer( problemset, penstockset, N )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         CONSTANTES DEL PROBLEMA                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PERFIL DE RÍO

    s0 = problemset.river(1,:);
    h0 = problemset.river(2,:);
    
    s  = linspace(s0(1),s0(end),N);
    h  = interp1(s0,h0,s);

% PERFIL DE RÍO

    kappa  = problemset.kappa;
    Qav    = problemset.Qav;
    Pmin   = problemset.Pmin;
    E_sop  = problemset.E_sop;
    E_exc  = problemset.E_exc;

    Dnoz   = penstockset.Dnoz;
    Snoz   = pi*Dnoz^2/4;
    Dtf    = penstockset.Dtf;
    
% RESTO DE CONSTANTES

    Nvar   = N*(N+1)/2;
    g      = 9.8;
    rho    = 1e3;
    rend   = 0.85;

    % Pérdidas por friccion    
    f = 10.674/(150^1.852);
    
% PREPROCESO DEL PERFIL
    
ds  = zeros(1,N*(N-1)/2);
dh  = zeros(1,N*(N-1)/2);
dsu = zeros(1,N*(N-1)/2);
for caso=1:N
    for j=caso+1:N
        ds(caso,j) = s(j)-s(caso);
        dh(caso,j) = h(j)-h(caso);
    end
end
for caso=1:N
    for j=caso+1:N
        dsu(caso,j) = ds(j-1,j);
    end
end

l                   = sqrt(dh.^2+ds.^2);
m                   = dh./ds;

vec_m               = m';
vec_l               = l';
% vec_ds              = ds';
% vec_dsu             = dsu';
vec_dh              = dh';

vec_m(isnan(vec_m)) = [];
vec_l(vec_l==0)     = [];
% vec_ds(vec_ds==0)   = [];
% vec_dsu(vec_dsu==0) = [];
vec_dh(vec_dh==0)   = [];

d                   = s(2:end)-s(1:end-1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                        PROBLEMA DE OPTIMIZACIÓN                         %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MATRICES DE RESTRICCIONES:    A·x < b     Aeq·x = beq

    A   = [];
    b   = [];

    Aeq = [];
    beq = [];
    
    % Definicion de GAMMA_jk
        A_gamma1 = -1*eye(N-1,N);
        for caso = 1:N-1
            v    = zeros(N-1,1) ;
            v(caso) = 1;
            A_gamma1   = [ A_gamma1 v*ones(1,N-caso)]; %#ok
        end
        b_gamma1 = zeros(N-1,1);
        A_gamma2 = [ zeros(N-1,1) -1*eye(N-1,N-1) ];
        for caso = 1:N-1
            A_gamma2 = [ A_gamma2 [zeros(caso-1,N-caso); eye(N-caso)] ]; %#ok
        end
        b_gamma2 = zeros(N-1,1);

        A = [ A; A_gamma1; A_gamma2 ];
        b = [ b; b_gamma1; b_gamma2 ];
        
        Aeq = [ Aeq; ones(1,N) -1*ones(1,N*(N-1)/2) ];
        beq = [ beq; 1 ];

    % Restricciones de altura máxima de soportes    
        A_sop = [];
        for caso = 1:N-1
            A_sop = [ [ zeros(N-1-caso,caso); triu(ones(caso)) ] A_sop];  %#ok
        end
        for caso = 1:N-1
            A_sop(caso,:) = A_sop(caso,:).*(vec_m - m(caso,caso+1)).*d(caso);  %#ok
        end
        for caso = 2:N-1
            A_sop(caso,:) = A_sop(caso,:) + A_sop(caso-1,:);  %#ok
        end
        
        b_sop = ones(N-1,1)*E_sop;

        A = [A; zeros(N-1,N) A_sop];
        b = [b; b_sop];

    % Restricciones de profundidad máxima de excavación
        A_exc = [];
        for caso = 1:N-1
            A_exc = [ [ zeros(N-1-caso,caso); triu(ones(caso)) ] A_exc];  %#ok
        end
        for caso = 1:N-1
            A_exc(caso,:) = A_exc(caso,:).*(vec_m - m(caso,caso+1)).*d(caso);  %#ok
        end
        for caso = 2:N-1
            A_exc(caso,:) = A_exc(caso,:) + A_exc(caso-1,:);  %#ok
        end
        A_exc = [zeros(N-1,N) -1*A_exc];
        b_exc = ones(N-1,1)*E_exc;
        
        A = [A; A_exc];
        b = [b; b_exc];
        
    % Restricción de potencia generada
        
        a1 = -(sqrt(2*g)*Snoz*rend*rho*g)^(2/3);
        a2 =  Pmin^(2/3)*2*g*Snoz^2*f/Dtf^5;
        a3 = -Pmin^(2/3);
        
        A_potmin = [ zeros(1,N) a1*vec_dh+a2*vec_l ];
        b_potmin = a3;
        
        A = [A; A_potmin];
        b = [b; b_potmin];
        
    % Restricción de caudal máximo
    
        b1 = 2*g*Snoz^2*Dtf^5;
        b2 = -2*g*Snoz^2*(kappa*Qav)^2*f;
        b3 = (kappa*Qav)^2*Dtf^5;
        
        A_Qmax = [ zeros(1,N) b1*vec_dh+b2*vec_l ];
        b_Qmax = b3;
        
        A = [A; A_Qmax];
        b = [b; b_Qmax];
        
    % Bounds
    
        lb = zeros(1,N*(N+1)/2);
        ub = ones(1,N*(N+1)/2);

    % Restricción de altura mínima (para depurar)
        
    %     A5 = -1*[ zeros(1,N) vec_m.*vec_dsu ];
    %     b5 = -1*[ Hmin ];
    %     A  = [ A; A5 ];
    %     b  = [ b; b5 ];
    
% FUNCIÓN OBJETIVO
    
    CosteCodo = problemset.CosteCodo;            % Coste equivalente en m de 1 codo
    
    F_codos = [ ones(1,N) zeros(1,N*(N-1)/2) ];  % Total de codos
    F_longi = [ zeros(1,N) vec_l ];              % Longitud total
    F_coste = CosteCodo*F_codos + F_longi;
    
    options = optimset('Display','off');
   
    tic;
    [sol,fval,~,~] = intlinprog(F_coste, 1:Nvar, A, b, Aeq, beq, lb, ub);
    tiempo = toc;
    
    if ~isempty(sol)
        
        Hg = [ zeros(1,N) vec_dh ]*sol;
        L  = [ zeros(1,N) vec_l ]*sol;
        C  = fval;
        Q  = (Hg/(1/(2*g*Snoz^2)+f/Dtf^5*L))^.5;
        P  = rend*rho*g*Q*Hg;
        
        
        s_codos = s'.*sol(1:N);
        s_codos(find(s_codos==0)) = [];
        
        results  = [ C P Hg L Q ];
        penstock = s_codos;
        
    else
        
        results  = [];
        penstock = [];
        
    end
    
end

