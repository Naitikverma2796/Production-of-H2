clear all;
clc;

U0 = [0;0;0;0;0;0;0;0;0;0]; % initialising the variables
U=U0;
format long g;
result = fsolve(@myresidual,U0) 

function R = myresidual(U)
% unpacking all the variables 

F_8 =  U(1); % Mass flow of Stream 8 (input to the mixer unit)
F_9 =  U(2); % Mass flow of Stream 9 (output from mixer unit)
F_10 = U(3); % Mass flow of Stream 10 (output from gasifier unit)
F_13 = U(4); % Mass flow of Stream 13 (input to INY-1 unit)
F_15 = U(5); % Mass flow of Stream 15 (output from INY-1 and input to WGS-1 reactor)
F_16 = U(6); % Mass flow of Stream 16 (output from INY-1 unit)
F_18 = U(7); % Mass flow of Stream 18 (water outlet from WGS-1 reactor unit)
F_20 = U(8); % Mass flow of Stream 20 (input to FT-1 unit)
F_21 = U(9); % Mass flow of Stream 21 (output from FT-1 unit containing only CO and CO2)
P   = U(10); % Mass flow of Stream P (final output stream containing almost 100% H2 only)


% NOMENCLATURE - 
% "Wi_j" - Weight of (i)th compound in (j)th stream (in kg)
% "F_i" - Mass flow rate of the (i)th stream (in kg/hr)


% 1st Stream
F_1 = 7402.13; % flow rate of the inlet i.e. Stream 1
% Inlet stream is 85% of Biomass and 15% water
WC_1 = (0.7974)*F_1*(0.2735);   % C is 47% of the Biomass
WI_1  = (0.7974)*F_1*(0.0677); % Inorganic matter(I) is 4.7% of the Biomass 
WO_1 = (0.7974)*F_1*(0.5930);   % O is 41% of the Biomass
WS_1 = (0.7974)*F_1*(0.0065);  % S is 0.3% of the Biomass
WN_1 = (0.7974)*F_1*(0.0011);   % N is 1% of the Biomass
WH_1 = (0.7974)*F_1*(0.0582);   % H is 6% of the Biomass
WH2O_1 = (0.2026)*F_1;        % H2O is 15% of the Inlet stream


% 3rd Stream    
F_3 = 1500; % 15% of F_1
WH2O_3 = WH2O_1;


%4th Stream
F_4 = 5902.13; % 85% of F_1
% Since, all weights of the 4th stream are equal to 1st stream - 
WC_4=WC_1;
WI_4=WI_1;
WO_4=WO_1;
WS_4=WS_1;
WN_4=WN_1;
WH_4=WH_1;


%5th Stream
F_5 = 5502.63; 
WI_5 =  0; % since, F_5 does not contain any inorganic matter
% all other weights of 5th stream are same as that of the 4th stream -
WC_5=WC_4;
WO_5=WO_4;
WS_5=WS_4;
WN_5=WN_4;
WH_5=WH_4;


% 6th Stream
F_6 = 399.5; % contains only inorganic matter
WI_6 = WI_4; % weight of inorganic matter in 6th stream is the same as that in the 4th stream


% 7th stream 
F_7 = F_5 + 2597.87; % mass balance at the burner unit 
% STREAM 7 COMPOSITIONS (AS ALREADY SPECIFIED IN THE PROBLEM STATEMENT)
WCO2_7 =0.475*F_7;
WH2O_7 =0.32*F_7 ;
WCO_7 = 0.15*F_7;
WH2_7 = 0.04*F_7;
WCH4_7 = 0.008*F_7;
WH2S_7 = 0.004*F_7;
WSO2_7=0.002*F_7;
WNH3_7 = 0.001*F_7;


% 8th Stream (This is another Inlet stream containing Carbon dioxide and 
% Carbon(char), whose composition is fixed and known to us)
WCO2_8 = 376.524;
WC_8 = 2880.177;
WH2O_8 = 0; % no H2O is present in this stream


% 9th Stream
WCO2_9 = WCO2_8 + WCO2_7; % CO2 balance at the mixer unit  
WH2O_9 = WH2O_8 + WH2O_7; % H2O balance at the mixer unit 
WC_9 = WC_8;              % C balance at the mixer unit (since no carbon(char) is present in stream 7)
% weights of all other components(except Inorganic matter) in 9th stream are same as that in the 7th stream -
WSO2_9 = WSO2_7;
WNH3_9 = WNH3_7;
WCO_9  = WCO_7;
WH2_9 = WH2_7;
WCH4_9 = WCH4_7;
WH2S_9 = WH2S_7;
% weight of inorganic matter in 9t stream is same as that in the 6th stream
WI_9 = WI_6;


% 10th Stream 
% C0 and H2 balance at the Gasifier unit (considering the reactions in the
% gasifier unit) -
WCO_10 = WCO_7 + (2*(0.4)*(WC_9/12)  + (0.6)*(WC_9/12))*28; 
WH2_10 = WH2_7 + (0.6)*(WC_9/12)*2; 
% new weights of C, CO2 and H2O (since C,CO2 and H2O are being consumed in the
% reaction) -
WCO2_10 = WCO2_9 - (0.4)*(WC_9/12)*44 ;
WH2O_10 = WH2O_9 - (0.6)*(WC_9/12)*18 ;
WC_10 = 0; % all C is consumed in the 2 reactions
% weights of all other components in 10th stream are same as that in the
% 9th stream - 
WSO2_10 = WSO2_9;
WNH3_10 = WNH3_9;
WI_10 = WI_9;
WCH4_10= WCH4_9;
WH2S_10 = WH2S_9;


% 11th stream 
% all the inorganic matter is removed from the system and released via
% stream 11
F_11 = 399.5;
WI_11 = WI_10; % inorganic matter in 11 stream is all of the inorganic matter of the 10th stream


% 13th stream 
% weight of all components(except Inorg. matter i.e.=0) in the 13th stream are the same as in the 10th stream  
WCO_13 = WCO_10;
WH2_13 = WH2_10;
WCO2_13 = WCO2_10; 
WH2O_13 = WH2O_10;
WC_13 = WC_10;
WSO2_13 = WSO2_10;
WNH3_13 = WNH3_10;
WCH4_13= WCH4_10;
WH2S_13 = WH2S_10;
WI_13 =0;


% 14th stream 
F_14 = 46778; % INPUT METHYLDIETHANOLAMINE


% 15th stream 
% contains only CO and H2 from stream 13 
WCO_15 = WCO_13;
WH2_15 = WH2_13;


% 16th stream
% contains all other components of stream 13 except CO and H2
WCO2_16 = WCO2_13;
WH2O_16 = WH2O_13;
WC_16   =   WC_13;
WSO2_16 = WSO2_13;
WNH3_16 = WNH3_13;
WCH4_16 = WCH4_13;
WH2S_16 = WH2S_13;


% WGS-1 REACTOR unit
F_17 = 10000; % this is the water input to the WGS-1 reactor to carry out the water gas shift reactions 
WH2O_17 = F_17; % contains only water
Z = 0.9; % extent of WGS reactor
nH2O_17 = WH2O_17/18; % moles of H2O in stream 17
nCO_15 = WCO_15/28;   % moles of CO in stream 15


% 20th stream (contains the products of the WGS reactor after the WGS reactor reactions)
if nH2O_17 < nCO_15   % H2O is limiting reactant
    % weights of CO2, H2 and CO in stream 20 - 
    WCO2_20 = (Z)*nH2O_17*(44); 
    WH2_20 = WH2_15 + (Z)*nH2O_17*(2);
    WCO_20 = WCO_15 - (Z)*nH2O_17*(28);
    % since water is limiting reactant, some water which is left will be removed from stream 18 - 
    R(7) = F_18 - (nH2O_17 - (Z)*nH2O_17)*(18); % this is one of the residuals since F_18 is an unknown

elseif nH2O_17 > nCO_15 % CO is limiting reactant
    % weights of CO2, H2 and CO in stream 20 -    
    WCO2_20 = (Z)*nCO_15*(44);
    WH2_20 = WH2_15 + (Z)*nCO_15*(2);
    WCO_20 = WCO_15 - (Z)*nCO_15*(28);
    % since some water will be left which will be removed via stream 18 - 
    R(7) = F_18 - (nH2O_17-Z*nCO_15)*(18); % this is one of the residuals since F_18 is an unknown
    
end


% 21st Stream
% this stream contains all of the CO from the 20th stream and 99.95% of the CO2 from the 20th stream - 
WCO_21 = WCO_20;
WCO2_21 = (0.9995)*WCO2_20;


% P stream
% this stream contains all of the H2 from the 20th stream and 0.05% of the CO2 from the 20th stream - 
WCO_P = 0; % no CO is present in this stream
WCO2_P = (1 - 0.9995)*WCO2_20;
WH2_P = WH2_20; % THIS IS THE FINAL PRODUCT OF THE PROCESS 


% Residual equations - 
R(1) = F_8 - WCO2_8 - WC_8;
R(2) = F_9 - F_6 - F_7 - F_8; 
R(3) = F_10 - F_9;
R(4) = F_13 - F_10 + F_11; 
R(5) = F_16 - F_13 - F_14 + F_15; 
R(6) = F_20 - F_17 - F_15 + F_18;

R(8) = F_21 - F_20 + P;
R(9) = F_20 - WCO_20 - WCO2_20 - WH2_20;
R(10) = F_21 - WCO_21 - WCO2_21;


end
