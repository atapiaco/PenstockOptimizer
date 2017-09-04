function results = solver( handles )

g       = 9.8;
rho     = 1e3;

river   = handles.data_input.river;
kappa   = handles.data_input.kappa;
Qriver  = handles.data_input.flow;
Pmin    = handles.data_input.Pmin;
E_sop   = handles.data_input.Esup;
E_exc   = handles.data_input.Eexc;
Dnoz    = handles.data_input.Dnoz;
Dp      = handles.data_input.Dp;
rend    = handles.data_input.rend;
mat     = handles.data_input.mat;
Cc      = handles.data_input.Cc;

s       = river(:,1);
h       = river(:,2);
N       = length(s);
Snoz    = pi*Dnoz^2/4;
vC      = [ 130 120 140 120 150 ];
C       = vC(mat);
f       = 10.674/(C^1.852);
Nvar    = N*(N+1)/2;
    
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

% CONSTRAINTS:    A·x < b     Aeq·x = beq

    A   = [];
    b   = [];

    Aeq = [];
    beq = [];
    
    % GAMMA_jk
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

    % Max supports    
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

    % Max excavation
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
        
    % Min power
        
        a1 = -(sqrt(2*g)*Snoz*rend*rho*g)^(2/3);
        a2 =  Pmin^(2/3)*2*g*Snoz^2*f/Dp^5;
        a3 = -Pmin^(2/3);
        
        A_potmin = [ zeros(1,N) a1*vec_dh+a2*vec_l ];
        b_potmin = a3;
        
        A = [A; A_potmin];
        b = [b; b_potmin];
        
    % Max flow
        b1 = 2*g*Snoz^2;
        b2 = -2*g*Snoz^2*f/Dp^5*(kappa*Qriver)^2;
        b3 = (kappa*Qriver)^2;
        
        A_Qmax = [ zeros(1,N) b1*vec_dh+b2*vec_l ];
        b_Qmax = b3;
        
        A = [A; A_Qmax];
        b = [b; b_Qmax];
        
    % Bounds
        lb = zeros(1,N*(N+1)/2);
        ub = ones(1,N*(N+1)/2);

    % Max height (to depurate)
        
    %     A5 = -1*[ zeros(1,N) vec_m.*vec_dsu ];
    %     b5 = -1*[ Hmin ];
    %     A  = [ A; A5 ];
    %     b  = [ b; b5 ];
    
% OBJECTIVE
    F_elbows    = [ ones(1,N) zeros(1,N*(N-1)/2) ];
    F_length    = [ zeros(1,N) vec_l ];
    F           = Cc*F_elbows + F_length;
    
%     options = optimset('Display','off');
   
    tic;
    [sol,fval,~,~] = intlinprog(F, 1:Nvar, A, b, Aeq, beq, lb, ub);
    solvingTime = toc;
    
    if ~isempty(sol)
        K1                  = sqrt(2*g)*Snoz*rend*rho*g;
        K2                  = 2*g*Snoz^2*f/Dp^5;
        s_p                 = s.*sol(1:N);
        s_p(find(s_p==0))   = []; %#ok
        results.Hg          = [ zeros(1,N) vec_dh ]*sol;
        results.L           = [ zeros(1,N) vec_l ]*sol;
        results.C           = fval;
        results.Q           = (results.Hg/(1/(2*g*Snoz^2)+f/Dp^5*results.L))^.5;
        results.P           = K1*(results.Hg/(1+K2*results.L))^1.5
        results.Nc          = length(s_p);
        results.penstock    = s_p;
        results.success     = 1;
        
    else
        
        results.success = 0;
        
    end
    
end

