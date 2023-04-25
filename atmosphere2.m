function [P,T,a,nu,g,rho] = atmosphere2 (h,delta_T)

% Calculate the atmospheric properties (S.I. Units)
%
%   Purpose:
%   ========
%       This function calculates the atmospheric properties 
%       as given by the formula from Cumpsty's book.
%       These correlations were chosen since the saturated 
%       atmosphere is also included.
%           [P,T,a,nu] = atmosphere (h,delta_T)
% Definition of variables:
% ========================
% Input:
% ------
%       h               -- the altitude of the atmosphere [m]
%       delta_T         -- the temperature difference from ISA [K]
% Output:
% -------
%       p               -- the pressure at altitude h [Pa]
%       T               -- the temperature at altitude h [K]
%       a               -- the speed of sound at altitude h [m/s]
%       nu              -- the kinematic viscosity of the air [m^2/s]
%       g               -- the gravitational acceleation [m/s^2]
%       rho             -- the density at altitude h [kg/m^3]

% Others:
% -------
%       gradT           -- the temperature gradient in the troposphere 
%       Tref            -- the reference temperature [K]
%       h_pref          -- the reference altitude [m]
%       Pref            -- the reference pressure [Pa]
%       R               -- the gas constant for air [J/kgK]
%       gamma           -- the ratio of specicific heats of air []
%       Ptr             -- the reference pressure at the tropopauze [Pa]

%   Record of revisions:
%   ====================
%		Date					Description of change
%		====					=====================
%		10/05/04				Original Code
%		03/07/04				* Beta testing 
%                               * Changed error to errordlg
%                               * added errors for negative input
%                               * added warnings for large input
%                               * Variable definition completed
%


% Actual calculation:
% ===================
% definitions of constants
%-------------------------
gradT=0.0065; 
Tref=288.15; 
h_pref=0; 
Pref=101325;
g=9.80665;
R=287.05; 

% Check for a legal number of input arguments
% -------------------------------------------
if nargin > 2
    errordlg('Wrong number of input arguments !',...
        'Fuselage geomerty');
    msg=nargchk(1,2,nargin);
    error(msg);
end

if nargin < 1
    errordlg('Wrong number of input arguments !',...
        'Fuselage geomerty');
    msg=nargchk(1,2,nargin);
    error(msg);
end

% Check whether the input arguments are reasonable
% ------------------------------------------------
% negative numbers are not possible

if h<0
    errordlg('U cannot fly lower than the sea!',...
        'Atmosphere');
    error('Not a correct input');
end
if h > 20000
    errordlg('The calculations are only valid up to 20 km!',...
        'Atmosphere');
    error('Not a correct input');
end

% warning if values are too large

if delta_T >= 50
    warndlg('The temperature difference from ISA is very large !',...
        'Atmosphere');
end
if delta_T <= -50
    warndlg('The temperature difference from ISA is very large !',...
        'Atmosphere');
end

% Actual calculation
% ------------------

% no dlta T given -> set to 0
if nargin < 2, delta_T = 0; end % no delta T specified means ISA

g=g/((1+h/6371020)^2);
Ptr=Pref*(1-gradT*10999/Tref)^(g/R/gradT);

if h <= 11000; % below the tropopause
    T=Tref-gradT*h;
    P=Pref*(1-gradT*h/Tref)^(g/R/gradT);
    T=T+delta_T;
    gam=gamma2(T);
    a=sqrt(gam*R*T); 
    rho=P/R/T;
    mu=1.458e-6*T^1.5/(T+110.4);
    nu=mu/rho;
else 
    T=216.65;
    P=Ptr*exp(g/R/T*(11000-h));
    T=T+delta_T;
    gam=gamma2(T);
    a=sqrt(gam*R*T); 
    rho=P/R/T;
    mu=1.458e-6*T^1.5/(T+110.4);
    nu=mu/rho;

end
