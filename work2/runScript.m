
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
save('saved_data/SEGMENT-NW-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for SEGMENT Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('SEGMENT',true,'FISHER')
graphACBRStats(totalStats,'WSEGMENT-FISHER')
save('saved_data/SEGMENT-WFISHER-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for SEGMENT Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('SEGMENT',true,'RELIEF')
graphACBRStats(totalStats,'WSEGMENT-RELIEF')
save('saved_data/SEGMENT-WRELIEF-results.mat','totalStats');


%% PENBASED DATASET
%% Generating data and figures for SEGMENT Database - Non Weighted
disp('Generating data and figures for PENBASED Database - Non Weighted');
totalStats = testAllACBRCombinations('PENBASED',false)
graphACBRStats(totalStats,'PENBASED')
save('saved_data/PENBASED-NW-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for PENBASED Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('PENBASED',true,'FISHER')
graphACBRStats(totalStats,'WPENBASED-FISHER')
save('saved_data/PENBASED-WFISHER-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for PENBASED Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('PENBASED',true,'RELIEF')
graphACBRStats(totalStats,'WPENBASED-RELIEF')
save('saved_data/PENBASED-WRELIEF-results.mat','totalStats');


%% WAVEFORM DATASET
%% Generating data and figures for SEGMENT Database - Non Weighted
disp('Generating data and figures for WAVEFORM Database - Non Weighted');
totalStats = testAllACBRCombinations('WAVEFORM',false)
graphACBRStats(totalStats,'WAVEFORM')
save('saved_data/WAVEFORM-NW-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Fisher Selection
disp(' Generating data and figures for WAVEFORM Database - Weighted / Fisher Selection');
totalStats = testAllACBRCombinations('WAVEFORM',true,'FISHER')
graphACBRStats(totalStats,'WWAVEFORM-FISHER')
save('saved_data/WAVEFORM-WFISHER-results.mat','totalStats');

%% Generating data and figures for ZOO Database - Weighted / Relief Selection
disp('Generating data and figures for WAVEFORM Database - Weighted / Relief Selection');
totalStats = testAllACBRCombinations('WAVEFORM',true,'RELIEF')
graphACBRStats(totalStats,'WWAVEFORM-RELIEF')
save('saved_data/WAVEFORM-WRELIEF-results.mat','totalStats');


