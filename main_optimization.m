
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                                CONSTANTES                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                          PERFIL DEL RÍO                             %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     puntos = 30;
%     s0 = [1:puntos]*400/puntos;
%     h0 = sort( 0.2+80*rand(puntos,1) );
%     s  = linspace(s0(1),s0(end),1e3);
%     h  = sort(spline(s0,h0,s));
%     plot(s0,h0,'.',s,h,'-')
%     axis equal
    
%     load('riverProfile.mat');
    load('riverProfile2.mat');
    problemset.river    = river;
    
    river(1,:) = river(1,:)*1e3/river(1,end);
    river(2,:) = river(2,:)*250/river(2,end);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                     PARAMETROS DEL PROBLEMA                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    vN    = floor(logspace(1,log10(300),10));
    
    casos  = length(vN);
    
    problemset.CosteCodo = 20;
    problemset.kappa     = 0.5;
    problemset.Qav       = 70e-3;
    problemset.Pmin      = 10e3;
    problemset.E_sop     = 1.0;
    problemset.E_exc     = 0.5;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                     CONSTANTES DE LA TUBERÍA                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    penstockset.Dnoz     = 22e-3;
    penstockset.Dtf      = 20e-2;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           ANÁLISIS PARAMÉTRICO                          %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   RESOLUCIÓN EN FUNCION DE vN                       %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    data              = zeros(casos,8);
    optimal_penstocks = cell(1,casos);
    
    for i = 1:casos
        
        N    = vN(i);
        nvar = N*(N+1)/2;
         
        [ results, tiempo, penstock_nodes ] = f_PenstockOptimizer( problemset, penstockset, N );
        
        penstock_nodes(find(penstock_nodes<=0.01)) = [ ]; %#ok
        
%       maxgap = f_GapVerification( problemset, penstock_nodes );
        
        [ data(i,:) ] = [ N, nvar, tiempo, results ];
        % N Nvar Time C P Hg L Q
        
        optimal_penstocks{i} = penstock_nodes;       
        
        fprintf('\n\n');
        fprintf('Resuelto caso %d/%d.\n',i,casos);
        
    end

%% Para múltiples casos
    
    close all
    
        N  = 200;
        s  = linspace(river(1,1),river(1,end),N);
        h  = interp1(river(1,:),river(2,:),s);
        
%     figure(1)
%     subplot(2,1,1)
%         xlabel('Number of variables')
%         yyaxis left
%         semilogx(data(:,2),data(:,3),'-d');
%         ylabel('Solving time [s]')
%         yyaxis right
%         semilogx(data(:,2),data(:,4),'-d');
%         ylabel('Cost [m]')
% 	subplot(2,1,2)
%         semilogx(data(:,2),data(:,end),'o');
    
    figure(2)
    for i = 1:casos
        subplot(casos,1,i)
        plot(s,h,'.','MarkerSize',0.1)
        hold all
        plot(optimal_penstocks{i},interp1(river(1,:),river(2,:),optimal_penstocks{i}),'dk-','LineWidth',1.5)
        axis equal
        grid
        axis([ 0 river(1,end) 0 300 ]);
        xlabel('xlabel')
        ylabel('ylabel')
        h_alvaro = legend({'River discretization','Optimal penstock'});
        set(h_alvaro,'Interpreter','latex')
    end
    
%       h = legend('$\frac{1}{r^3}$');
%         set(h,'Interpreter','latex')
%         
%% Para un caso particular
        
        N  = 200;
        s  = linspace(river(1,1),river(1,end),N);
        h  = interp1(river(1,:),river(2,:),s);
    
    figure(3)
        plot(s,h,'.')
        hold all
        plot(river(1,:),river(2,:),'.')
        axis equal
        grid
        axis([ 0 river(1,end) 0 300 ]);
        xlabel('xlabel')
        ylabel('ylabel')

        
    figure(4)
        plot(s,h,'.','MarkerSize',0.1)
        hold all
        plot(optimal_penstocks{1},interp1(river(1,:),river(2,:),optimal_penstocks{1}),'dk-','LineWidth',1)
        axis equal
        grid
        axis([ 0 river(1,end) 0 300 ]);
        xlabel('xlabel')
        ylabel('ylabel')
        legend({'River discretization','Optimal penstock'})
%         legend({'River discretization')
        

