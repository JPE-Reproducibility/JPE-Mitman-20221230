function par=BKKS_load_parameters(model_to_run,excellocation)
%model_to_run ... the number of the model you want to run

% maxNumCompThreads(1)

%load the excel sheet
filename = [excellocation 'modelsMasterExcel.xlsx'];
CellData = readcell(filename); 
parnames=CellData(2:end,1);

%find the particular column in the excel sheet with the parameters
index = find(cell2mat(CellData(2,3:end))==model_to_run);
parvalues=CellData(2:length(parnames)+1,2+index);


%extract the parameters
for i=1:length(parnames)
    eval(['par.' parnames{i} '=parvalues{i};'])
end
