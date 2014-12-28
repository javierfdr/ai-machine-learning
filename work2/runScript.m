
%% Script for testing all the combinations and generated associated figures
clc;clear;
init;

%% ZOO DATASET
%% Generating data and figures for ZOO Database - Non Weighted
disp('Generating data and figures for ZOO Database - Non Weighted');
totalStats = testAllACBRCombinations('ZOO',false)
graphACBRStats(totalStats,'ZOO')
save('saved_data/ZOO-NW-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for ZOO Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('ZOO',true,'FISHER')
graphACBRStats(totalStats,'WZOO-FISHER')
save('saved_data/ZOO-WFISHER-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for ZOO Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('ZOO',true,'RELIEF')
graphACBRStats(totalStats,'WZOO-RELIEF')
save('saved_data/ZOO-WRELIEF-results.mat','totalStats');


%% SEGMENT DATASET
%% Generating data and figures for SEGMENT Database - Non Weighted
disp('Generating data and figures for SEGMENT Database - Non Weighted');
totalStats = testAllACBRCombinations('SEGMENT',false)
graphACBRStats(totalStats,'SEGMENT')

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for SEGMENT Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('SEGMENT',true,'FISHER')
graphACBRStats(totalStats,'WSEGMENT-FISHER')

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for SEGMENT Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('SEGMENT',true,'RELIEF')
graphACBRStats(totalStats,'WSEGMENT-RELIEF')


%% PENBASED DATASET
%% Generating data and figures for SEGMENT Database - Non Weighted
disp('Generating data and figures for PENBASED Database - Non Weighted');
totalStats = testAllACBRCombinations('PENBASED',false)
graphACBRStats(totalStats,'PENBASED')

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for PENBASED Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('PENBASED',true,'FISHER')
graphACBRStats(totalStats,'WPENBASED-FISHER')

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for PENBASED Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('PENBASED',true,'RELIEF')
graphACBRStats(totalStats,'WPENBASED-RELIEF')


%% WAVEFORM DATASET
%% Generating data and figures for SEGMENT Database - Non Weighted
disp('Generating data and figures for WAVEFORM Database - Non Weighted');
totalStats = testAllACBRCombinations('WAVEFORM',false)
graphACBRStats(totalStats,'WAVEFORM')

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for WAVEFORM Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('WAVEFORM',true,'FISHER')
graphACBRStats(totalStats,'WWAVEFORM-FISHER')

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for WAVEFORM Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('WAVEFORM',true,'RELIEF')
graphACBRStats(totalStats,'WWAVEFORM-RELIEF')


