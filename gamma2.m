function [gamma] = gamma2(T)

% Calculate the ratio of specific heats for air (SI Units)
%
%   Purpose:
%   ========
%       This function calculates the ratio of specific heats for
%       air in function of the input temperature (static)
%               [gamma] = gamma(T)
%
%   Record of revisions:
%   ====================
%		Date					Description of change
%		====					=====================
%		05/07/04				Original Code
%
% Definition of variables:
% ========================
%
% Input:
% ------
%       T               -- the static temperature of the air [K]
%
% Output:
% -------
%       gamma           -- the ratio of specific heats of air
%
% Others:
% -------
%       c_p             -- the specific heat of air [J/kg/K]

% Actual calculation:
% ===================
% definitions of constants
% ------------------------
a0=0.992313;
a1=0.236688;
a2=-1.852148;
a3=6.083152;
a4=-8.893933;
a5=7.097112;
a6=-3.234725;
a7=0.794571;
a8=-0.081873;
R=287.05;

% Check for a legal number of input arguments
% -------------------------------------------
if nargin ~= 1
    errordlg('Wrong number of input arguments !',...
        'Gamma');
    msg=nargchk(1,1,nargin);
    error(msg);
end

% Check whether the input arguments are reasonable
% ------------------------------------------------
% negative numbers are not possible

if T<=0
    errordlg('The static temperature cannot be zero or less!',...
        'Gamma');
    error('Not a correct input');
end

% warning if values are too large

% actual calculation
% ------------------

t=T/1000;
cp=a0+a1.*t+a2.*t.^2+a3.*t.^3+a4.*t.^4+a5.*t.^5+a6.*t.^6+a7.*t.^7+a8.*t.^8;
cp=cp.*1000;
gamma=cp./(cp-R);


