%Rose Long


%import data as table. 
%manualcell is table name

% subscripted using parentheses much like ordinary numeric
    %arrays, but in addition to numeric and logical indices, you can use a
    %table's variable and row names as indices
    %use braces to select mroe than one
%import data range: A2:AK72
%********************
%enter these variables
tt = 4; %number of E12 embryos
ff = 4; %number of E14 embryos, actually 4
ss = 4; %number of E17 embryos
path(path, 'C:\Users\Rose\Desktop\aa123rose\matlabplots')
path(path, 'C:\Users\Rose\Desktop\aa123rose\matlabplots\breakxaxis')
%load manualcell %load teh current data saved on desktop, from 12/21/23 older:12/11/23

%% make new data columns
% create total vertebra area
manualcell.Vertebra_area = manualcell.ventral_VB_Area + manualcell.Dorsal_VB_Area;

manualcell.AF_area = manualcell.Ventral_AF_area + manualcell.Dorsal_AF_Area;

manualcell.Notochord_area = manualcell.Noto_IVD_Area + manualcell.Noto_VB_Area;

%vertebral density
manualcell.density_VB = (manualcell.Dorsal_VB_total + manualcell.Ventral_VB_total)./manualcell.Vertebra_area;
%Noto density
manualcell.density_AF = (manualcell.Dorsal_AF_Total + manualcell.Ventral_AF_Total)./manualcell.AF_area;

manualcell.density_Noto = (manualcell.Noto_VB_total + manualcell.Noto_IVD_Total)./manualcell.Notochord_area;

%calculate percent prolfierating
manualcell.AF_pp = (manualcell.Dorsal_AF_Edu+ manualcell.Ventral_AF_Edu)./(manualcell.Dorsal_AF_Total+manualcell.Ventral_AF_Total);

manualcell.VB_pp = (manualcell.Dorsal_VB_Edu+ manualcell.Ventral_VB_Edu)./(manualcell.Dorsal_VB_total+manualcell.Ventral_VB_total);

manualcell.Noto_pp = (manualcell.Noto_IVD_Edu+ manualcell.Noto_VB_Edu)./(manualcell.Noto_IVD_Total+manualcell.Noto_VB_total);
%% plot the vertebral area swarm chart
figure
daynames = ["E12.5" "E14.5" "E17.5"];
x = categorical(manualcell.Stage,[12,14,17],daynames);
%does not work yet, neet editing out stage to level manualcell.Region = categorical(manualcell.Stage,[12,14,17],daynames)
y = manualcell.Vertebra_area;
c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(pink)
s.XJitterWidth = 0.5;
title('Vertebra Area')
ylabel('Area (um^2)')
embryo_logic = manualcell.Stage == 12;
median12 = median(manualcell.Dorsal_VB_Area(embryo_logic),'omitnan')
stddev12 = std(manualcell.Dorsal_VB_Area(embryo_logic),'omitnan')
%median(manualcell.Dorsal_VB_Area(manualcell.Stage == 14)) counts E17 as well
%for some reasion. 
d = errorbar([median(manualcell.Vertebra_area(manualcell.Stage == 12),'omitnan') median(manualcell.Vertebra_area(manualcell.Stage == 14),'omitnan') median(manualcell.Vertebra_area(manualcell.Stage == 17),'omitnan')],[std(manualcell.Vertebra_area(manualcell.Stage == 12),'omitnan') std(manualcell.Vertebra_area(manualcell.Stage == 14),'omitnan') std(manualcell.Vertebra_area(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];

%stop and make plot area smaller be grabbing outside of box
%print('-dtiff',['VB_Area_20240328','.tif']);
%m00010('VB_Area2_20240328')

median(manualcell.Vertebra_area(manualcell.Stage == 12),'omitnan') 
median(manualcell.Vertebra_area(manualcell.Stage == 14),'omitnan') 
median(manualcell.Vertebra_area(manualcell.Stage == 17),'omitnan')
std(manualcell.Vertebra_area(manualcell.Stage == 12),'omitnan') 
std(manualcell.Vertebra_area(manualcell.Stage == 14),'omitnan') 
    std(manualcell.Vertebra_area(manualcell.Stage == 17),'omitnan')

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.Vertebra_area,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])
%% plot the notochord area
daynames = ["E12.5" "E14.5" "E17.5"];
x = categorical(manualcell.Stage,[12,14,17],daynames);
y = manualcell.Notochord_area;
c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Notochord Area')
ylabel('Area (um^2)')

d = errorbar([median(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan') median(manualcell.Notochord_area(manualcell.Stage == 14),'omitnan') median(manualcell.Notochord_area(manualcell.Stage == 17),'omitnan')],[std(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan') std(manualcell.Notochord_area(manualcell.Stage == 14),'omitnan') std(manualcell.Notochord_area(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];

%stop and make plot area smaller be grabbing outside of box
print('-dtiff',['Notochord_Area','.tif']);
m00010('Noto_Area2')

median(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan') 
median(manualcell.Notochord_area(manualcell.Stage == 14),'omitnan') 
median(manualcell.Notochord_area(manualcell.Stage == 17),'omitnan')
std(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan') 
std(manualcell.Notochord_area(manualcell.Stage == 14),'omitnan') 
    std(manualcell.Notochord_area(manualcell.Stage == 17),'omitnan')


%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.Notochord_area,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])
%% plot AF area

daynames = ["E12.5" "E14.5" "E17.5"];
x = categorical(manualcell.Stage,[12,14,17],daynames);
y = manualcell.AF_area;
c = (manualcell.Level_number);

s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('AF Area')
ylabel('Area (um^2)')

d = errorbar([median(manualcell.AF_area(manualcell.Stage == 12),'omitnan') median(manualcell.AF_area(manualcell.Stage == 14),'omitnan') median(manualcell.AF_area(manualcell.Stage == 17),'omitnan')],[std(manualcell.AF_area(manualcell.Stage == 12),'omitnan') std(manualcell.AF_area(manualcell.Stage == 14),'omitnan') std(manualcell.AF_area(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];

%stop and make plot area smaller be grabbing outside of box
% print('-dtiff',['AF_Area','.tif']);
% m00010('Noto_Area2')

median(manualcell.AF_area(manualcell.Stage == 12),'omitnan') 
median(manualcell.AF_area(manualcell.Stage == 14),'omitnan') 
median(manualcell.AF_area(manualcell.Stage == 17),'omitnan')
std(manualcell.AF_area(manualcell.Stage == 12),'omitnan') 
std(manualcell.AF_area(manualcell.Stage == 14),'omitnan') 
    std(manualcell.AF_area(manualcell.Stage == 17),'omitnan')


%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.AF_area,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])


%% Figure 2 D plot the change in area for annulus, vertebra, notochord and total
% average the areas of each time point, then subtract to get bar chart. 
figure
daynames = ["E12.5" "E14.5" "E17.5"];
x = categorical(manualcell.Stage,[12,14,17],daynames);
e12_vb_area = mean(manualcell.Vertebra_area(x == 'E12.5'),'omitnan');
e12_noto_area = mean(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan');
e12_af_area = mean(manualcell.AF_area(manualcell.Stage == 12),'omitnan');
e14_vb_area = mean(manualcell.Vertebra_area(x == 'E14.5'),'omitnan');
e14_noto_area = mean(manualcell.Notochord_area(x == 'E14.5'),'omitnan');
e14_af_area = mean(manualcell.AF_area(x == 'E14.5'),'omitnan');
e17_vb_area = mean(manualcell.Vertebra_area(x == 'E17.5'),'omitnan');
e17_noto_area = mean(manualcell.Notochord_area(x == 'E17.5'),'omitnan');
e17_af_area = mean(manualcell.AF_area(x == 'E17.5'),'omitnan');
y = [e14_noto_area-e12_noto_area e17_noto_area-e14_noto_area; e14_af_area-e12_af_area e17_af_area-e14_af_area; e14_vb_area-e12_vb_area e17_vb_area-e14_vb_area];
z = round(y./[e12_noto_area e14_noto_area; e12_af_area e14_af_area; e12_vb_area e14_vb_area]*100);
%wrong order and text lab only puts it in center of each bar y2 = reshape(y,[1,6])
%wrong orde, z2 = reshape(z,[1,6])
b = bar(y);
%text(1:length(z2),y2,num2str(z2'),'vert','bottom','horiz','center'); 
box off

hold on
title('Area Change')
ylabel('Area (um^2)')
d = gca;
d.FontSize = 15;
d.XTickLabel = [];


%stop and make plot area smaller be grabbing outside of box
% print('-dtiff',['Area_Change','.tif']);
% m00010('Area_Change2')

median(manualcell.AF_area(manualcell.Stage == 12),'omitnan') 
median(manualcell.AF_area(manualcell.Stage == 14),'omitnan') 
median(manualcell.AF_area(manualcell.Stage == 17),'omitnan')
std(manualcell.AF_area(manualcell.Stage == 12),'omitnan') 
std(manualcell.AF_area(manualcell.Stage == 14),'omitnan') 
std(manualcell.AF_area(manualcell.Stage == 17),'omitnan')

median(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan') 
median(manualcell.Notochord_area(manualcell.Stage == 14),'omitnan') 
median(manualcell.Notochord_area(manualcell.Stage == 17),'omitnan')
std(manualcell.Notochord_area(manualcell.Stage == 12),'omitnan') 
std(manualcell.Notochord_area(manualcell.Stage == 14),'omitnan') 
std(manualcell.Notochord_area(manualcell.Stage == 17),'omitnan')
figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.AF_area,x,'off')
%compare each groupensity_VB
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])



%% plot the Figure 3A density of VBa
daynames = ["E12.5" "E14.5" "E17.5"];
c = (manualcell.Level_number);
x = categorical(manualcell.Stage,[12,14,17],daynames);
y = manualcell.density_VB;
%c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Vertebra Density')
ylabel('Cell Density (cells/um^2)')

d = errorbar([median(manualcell.density_VB(manualcell.Stage == 12),'omitnan') median(manualcell.density_VB(manualcell.Stage == 14),'omitnan') median(manualcell.density_VB(manualcell.Stage == 17),'omitnan')],[std(manualcell.density_VB(manualcell.Stage == 12),'omitnan') std(manualcell.density_VB(manualcell.Stage == 14),'omitnan') std(manualcell.density_VB(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
% print('-dtiff',['density_VB','.tif']);
% m00010('density_VB2')

median(manualcell.density_VB(manualcell.Stage == 12),'omitnan') 
median(manualcell.density_VB(manualcell.Stage == 14),'omitnan') 
median(manualcell.density_VB(manualcell.Stage == 17),'omitnan')
std(manualcell.density_VB(manualcell.Stage == 12),'omitnan') 
std(manualcell.density_VB(manualcell.Stage == 14),'omitnan') 
std(manualcell.density_VB(manualcell.Stage == 17),'omitnan')
range(manualcell.density_VB(manualcell.Stage == 12),'omitnan') 
range(manualcell.density_VB(manualcell.Stage == 14),'omitnan') 
range(manualcell.density_VB(manualcell.Stage == 17),'omitnan')

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.density_VB,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

%% plot the Figure 3A density of AF
daynames = ["E12.5" "E14.5" "E17.5"];
c = (manualcell.Level_number);
x = categorical(manualcell.Stage,[12,14,17],daynames);
y = manualcell.density_AF;
%c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Annulus Fibrosus Density')
ylabel('Cell Density (cells/um^2)')

d = errorbar([median(manualcell.density_AF(manualcell.Stage == 12),'omitnan') median(manualcell.density_AF(manualcell.Stage == 14),'omitnan') median(manualcell.density_AF(manualcell.Stage == 17),'omitnan')],[std(manualcell.density_AF(manualcell.Stage == 12),'omitnan') std(manualcell.density_AF(manualcell.Stage == 14),'omitnan') std(manualcell.density_AF(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
%print('-dtiff',['density_AF','.tif']);
%m00010('density_AF2')

median(manualcell.density_AF(manualcell.Stage == 12),'omitnan') 
median(manualcell.density_AF(manualcell.Stage == 14),'omitnan') 
median(manualcell.density_AF(manualcell.Stage == 17),'omitnan')
std(manualcell.density_AF(manualcell.Stage == 12),'omitnan') 
std(manualcell.density_AF(manualcell.Stage == 14),'omitnan') 
    std(manualcell.density_AF(manualcell.Stage == 17),'omitnan')
    range(manualcell.density_AF(manualcell.Stage == 12),'omitnan') 
range(manualcell.density_AF(manualcell.Stage == 14),'omitnan') 
    range(manualcell.density_AF(manualcell.Stage == 17),'omitnan')


%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.density_AF,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])
%% plot the density of vb and af
daynames = ["E12.5 VB" "E14.5 VB" "E17.5 VB"];
c = [manualcell.Level_number;manualcell.Level_number];
x = categorical(manualcell.Stage,[12,14,17],daynames);
daynames = ["E12.5 AF" "E14.5 AF" "E17.5 AF"];
x2 = categorical(manualcell.Stage,[12,14,17],daynames);
x_x = [x;x2];
y = [manualcell.density_VB;manualcell.density_AF];
%c = (manualcell.Level_number);
s = swarmchart(x_x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Mesenchyme Density')
ylabel('Cell Density (cells/um^2)')

d = errorbar([median(manualcell.density_VB(manualcell.Stage == 12),'omitnan') median(manualcell.density_VB(manualcell.Stage == 14),'omitnan') median(manualcell.density_VB(manualcell.Stage == 17),'omitnan') median(manualcell.density_AF(manualcell.Stage == 12),'omitnan') median(manualcell.density_AF(manualcell.Stage == 14),'omitnan') median(manualcell.density_AF(manualcell.Stage == 17),'omitnan')],[std(manualcell.density_VB(manualcell.Stage == 12),'omitnan') std(manualcell.density_VB(manualcell.Stage == 14),'omitnan') std(manualcell.density_VB(manualcell.Stage == 17),'omitnan') std(manualcell.density_AF(manualcell.Stage == 12),'omitnan') std(manualcell.density_AF(manualcell.Stage == 14),'omitnan') std(manualcell.density_AF(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
%  print('-dtiff',['density_mesenchyme_20240317','.tif']);
%  m00010('density_mesenchyme_20240317')

median(manualcell.density_VB(manualcell.Stage == 12),'omitnan'); 
median(manualcell.density_VB(manualcell.Stage == 14),'omitnan'); 
median(manualcell.density_VB(manualcell.Stage == 17),'omitnan');
std(manualcell.density_VB(manualcell.Stage == 12),'omitnan'); 
std(manualcell.density_VB(manualcell.Stage == 14),'omitnan'); 
std(manualcell.density_VB(manualcell.Stage == 17),'omitnan');
range(manualcell.density_VB(manualcell.Stage == 12),'omitnan'); 
range(manualcell.density_VB(manualcell.Stage == 14),'omitnan'); 
range(manualcell.density_VB(manualcell.Stage == 17),'omitnan');

median(manualcell.density_AF(manualcell.Stage == 12),'omitnan'); 
median(manualcell.density_AF(manualcell.Stage == 14),'omitnan'); 
median(manualcell.density_AF(manualcell.Stage == 17),'omitnan');
std(manualcell.density_AF(manualcell.Stage == 12),'omitnan'); 
std(manualcell.density_AF(manualcell.Stage == 14),'omitnan'); 
std(manualcell.density_AF(manualcell.Stage == 17),'omitnan');
range(manualcell.density_AF(manualcell.Stage == 12),'omitnan'); 
range(manualcell.density_AF(manualcell.Stage == 14),'omitnan'); 
range(manualcell.density_AF(manualcell.Stage == 17),'omitnan');

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis([manualcell.density_VB;manualcell.density_AF],x_x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])


%% plot the Figure 3C density of Noto
daynames = ["E12.5" "E14.5" "E17.5"];
c = (manualcell.Level_number);
x = categorical(manualcell.Stage,[12,14,17],daynames);
y = manualcell.density_Noto;
%c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Notochord Density')
ylabel('Cell Density (cells/um^2)')

d = errorbar([median(manualcell.density_Noto(manualcell.Stage == 12),'omitnan') median(manualcell.density_Noto(manualcell.Stage == 14),'omitnan') median(manualcell.density_Noto(manualcell.Stage == 17),'omitnan')],[std(manualcell.density_Noto(manualcell.Stage == 12),'omitnan') std(manualcell.density_Noto(manualcell.Stage == 14),'omitnan') std(manualcell.density_Noto(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
% print('-dtiff',['density_Noto_20240327','.tif']);
% m00010('density_Noto_20240327')
figure

median(manualcell.density_Noto(manualcell.Stage == 12),'omitnan') 
median(manualcell.density_Noto(manualcell.Stage == 14),'omitnan') 
median(manualcell.density_Noto(manualcell.Stage == 17),'omitnan')
std(manualcell.density_Noto(manualcell.Stage == 12),'omitnan') 
std(manualcell.density_Noto(manualcell.Stage == 14),'omitnan') 
    std(manualcell.density_Noto(manualcell.Stage == 17),'omitnan')
    range(manualcell.density_Noto(manualcell.Stage == 12),'omitnan') 
range(manualcell.density_Noto(manualcell.Stage == 14),'omitnan') 
    range(manualcell.density_Noto(manualcell.Stage == 17),'omitnan')


%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.density_Noto,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

%% extra code
%plot a different marker per age 
% plot(x,y,'-o','MarkerIndices',[1 5 10]) displays a circle marker at the first, fifth, and tenth data points.

%Example: plot(x,y,'-x','MarkerIndices',1:3:length(y)) displays a cross marker every three data points.

%Example: plot(x,y,'Marker','square','MarkerIndices',5) displays one square marker at the fifth data point.

%% plot 3D vb density vs ratio
% density vs ratio 


%plot the vb density vs ratio for all stages
figure
    
    x = manualcell.IVD_over_VB_diameter;
    y = manualcell.density_VB;
    start = 50;
    stop = 150;
    width = 1;
    %leaves NaN for xtick folowing break h=BreakXAxis(x,y,start,stop,width)
    %try the different with the same name except one capital
    c = (manualcell.Level_number);
    new_c = c./max(c);
    v = plot(manualcell.IVD_over_VB_diameter, manualcell.density_VB,'.','MarkerSize',12)
    colormap(jet)
    hold on
    ax = gca; %Then set the XTick property using dot notation, such as 
    ax.XTick = [0:1:10 20:20:320]
    
    %ax.XTickLabel = []
    ax.FontSize = 20;
    title('Vertebra Cell Density vs IVD:VB ratio')
    ylabel('Cell Density (cells/um^2)')
    xlabel('IVD/VB (um/um)')
%stop here to reposition axes, and make smaller or larger    
print('-dtiff',['density_vertebra_level','.tif']);
m00010('vertebral_density_ratio')

%% plot figure #3, subfigure D, density vs ratio with fitline for all e14 points
% density vs ratio 

%with fitline for E14

%plot the vb density vs ratio for all stages
figure
hold on
    
    x = manualcell.IVD_over_VB_diameter;
    y = manualcell.density_VB;

    v = plot(manualcell.IVD_over_VB_diameter, manualcell.density_VB,'.','MarkerSize',15);
    hold on
    %fit line E14 data points
    x_e14 = x((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter < 3)
    y_e14 = y((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter < 3)
    length(x_e14)
    sum(isnan(x_e14))
    length(y_e14)
    sum(isnan(y_e14))
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = []
    x_e14(i) = []

    coef3 = polyfit(x_e14,y_e14,1)
    mn = min(x_e14);
    mx = max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'r')
    
        axis([0 10 0 0.04])

    ax = gca; %Then set the XTick property using dot notation, such as 
    %ax.XTick = [0:1:10 20:20:320]
    
    %ax.XTickLabel = []
    ax.FontSize = 20;
    title('Vertebra Cell Density vs IVD:VB ratio')
    ylabel('Cell Density (cells/um^2)')
    xlabel('IVD/VB (um/um)')
%stop here to reposition axes, and make smaller or larger    
%print('-dtiff',['density_vertebra_level_1_10_fit_e14','.tif']);
%m00010('vertebral_density_ratio_1_10_fit_e14_2')

%% calculate E14 density at ratio >2&<4, >4 with fitline for revisions, mark level with color
% density vs ratio 


%with fitline for E14

%plot the vb density vs ratio for all stages
figure
hold on
    
    x = manualcell.IVD_over_VB_diameter;
    y = manualcell.density_VB;
    c = manualcell.Level_number(manualcell.Stage == 14);
    v = plot(manualcell.IVD_over_VB_diameter(manualcell.Stage == 14), manualcell.density_VB(manualcell.Stage == 14),'.','MarkerSize',15);
    hold on

%     plot(x((manualcell.Stage == 12)), y((manualcell.Stage == 12)),'r.','MarkerSize',15);

%fit line E12 data points
    x_e14 = x((manualcell.Stage == 14))
    y_e14 = y((manualcell.Stage == 14))
    length(x_e14)
    sum(isnan(x_e14))
    length(y_e14)
    sum(isnan(y_e14))
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = []
    x_e14(i) = []

    [coef3,S] = polyfit(x_e14,y_e14,5)
    S.R;
    R_squared = 1 - (S.normr/norm(y_e14 - mean(y_e14)))^2
    mn = min(x_e14);
    mx = max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'r')
    %%%


    %fit line E14 data points with ratio <3
    x_e14 = x((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter < 3)
    y_e14 = y((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter < 3)
    length(x_e14);
    sum(isnan(x_e14));
    length(y_e14);
    sum(isnan(y_e14));
    fprintf ' median <3'
    median(y_e14,'omitnan')
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = []
    x_e14(i) = []

    [coef3,S] = polyfit(x_e14,y_e14,1)
    S.R;
    R_squared = 1 - (S.normr/norm(y_e14 - mean(y_e14)))^2
    mn = min(x_e14);
    mx = max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'k')
    clear y_e14 x_e14

    %fit line E14 data points with ratio between 2 and 4
    x_e14 = x((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter > 2 & manualcell.IVD_over_VB_diameter < 3);
    y_e14 = y((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter > 2 & manualcell.IVD_over_VB_diameter < 3);
    length(x_e14);
    sum(isnan(x_e14));
    length(y_e14);
    sum(isnan(y_e14));
    fprintf ' median >2, <3'
    median(y_e14,'omitnan')
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = [];
    x_e14(i) = [];

    [coef3,S] = polyfit(x_e14,y_e14,1)
    S.R;
    R_squared = 1 - (S.normr/norm(y_e14 - mean(y_e14)))^2
    mn = min(x_e14);
    mx = max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'c','LineWidth',3)
    clear y_e14 x_e14

    %plot ratio >4
    %fit line E14 data points
    x_e14 = x((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter > 3 & manualcell.IVD_over_VB_diameter < 4);
    y_e14 = y((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter > 3 & manualcell.IVD_over_VB_diameter < 4);
    length(x_e14);
    sum(isnan(x_e14));
    length(y_e14);
    sum(isnan(y_e14));
    fprintf ' median >3, <4'
    median(y_e14,'omitnan')
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = [];
    x_e14(i) = [];

    [coef3,S] = polyfit(x_e14,y_e14,1)
    S.R;
    R_squared = 1 - (S.normr/norm(y_e14 - mean(y_e14)))^2
    mn = min(x_e14);
    mx = max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'g','LineWidth',3)
    clear y_e14 x_e14

    %plot ratio >4
    %fit line E14 data points
    x_e14 = x((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter > 4 & manualcell.IVD_over_VB_diameter < 5);
    y_e14 = y((manualcell.Stage == 14) & manualcell.IVD_over_VB_diameter > 4 & manualcell.IVD_over_VB_diameter < 5);
    length(x_e14);
    sum(isnan(x_e14));
    length(y_e14);
    sum(isnan(y_e14));
    fprintf ' median >4, <5'
    median(y_e14,'omitnan')
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = [];
    x_e14(i) = [];

    [coef3,S] = polyfit(x_e14,y_e14,1)
    S.R;
    R_squared = 1 - (S.normr/norm(y_e14 - mean(y_e14)))^2
    mn = min(x_e14);
    mx = max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'r','LineWidth',3)
    clear y_e14 x_e14

    
        axis([0 10 0 0.04])

    ax = gca; %Then set the XTick property using dot notation, such as 
 ax.XTick = [0:1:10]
    
    %ax.XTickLabel = []
    ax.FontSize = 20;
    title('Vertebra Cell Density vs IVD:VB ratio')
    ylabel('Vertebral Cell Density (cells/um^2)')
    xlabel('IVD/VB (um/um)')
%stop here to reposition axes, and make smaller or larger    
% print('-dtiff',['density_vertebra_level_revison_fit','.tif']);
% m00010('vertebral_density_ratio_revision_fit')


%% plot 3D density vs ratio
% density vs ratio 

%with fitline for E14

%plot the vb density vs ratio for all stages
figure
hold on
    
    x = manualcell.IVD_over_VB_diameter;
    y = manualcell.density_VB;

    v = plot(manualcell.IVD_over_VB_diameter, manualcell.density_VB,'.','MarkerSize',15);
    hold on

%fit line E12 data points
    x_e14 = x((manualcell.Stage == 12))
    y_e14 = y((manualcell.Stage == 12))
    length(x_e14)
    sum(isnan(x_e14))
    length(y_e14)
    sum(isnan(y_e14))
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = []
    x_e14(i) = []

    coef1 = polyfit(x_e14,y_e14,1)
    mn = 0;%min(x_e14);
    mx = 2;%max(x_e14);
    y1 = polyval(coef1,mn:0.1:mx);
    plot(mn:0.1:mx,y1,'c')






    %fit line E14 data points
    x_e14 = x((manualcell.Stage == 14));% & manualcell.IVD_over_VB_diameter <3)
    y_e14 = y((manualcell.Stage == 14));% & manualcell.IVD_over_VB_diameter <3)
    length(x_e14)
    sum(isnan(x_e14))
    length(y_e14)
    sum(isnan(y_e14))
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = [];
    x_e14(i) = [];

    coef2 = polyfit(x_e14,y_e14,1)
    mn = 0;%min(x_e14);
    mx = 20;%max(x_e14);
    y2 = polyval(coef2,mn:0.1:mx);
    plot(mn:0.1:mx,y2,'r')
    %fit line E17 data points
    x_e14 = x((manualcell.Stage == 17));% & manualcell.IVD_over_VB_diameter <30)
    y_e14 = y((manualcell.Stage == 17));% & manualcell.IVD_over_VB_diameter <30)
    length(x_e14)
    sum(isnan(x_e14))
    length(y_e14)
    sum(isnan(y_e14))
    %remove the nan
    %v = [1 2 nan 2 nan]
    % i = isnan(x_e14);
    % x_e14(i) = []
    % 
    i = isnan(y_e14) |isnan(x_e14);
    y_e14(i) = []
    x_e14(i) = []

    coef3 = polyfit(x_e14,y_e14,1)
    mn = 0;%min(x_e14);
    mx = 30;%max(x_e14);
    y3 = polyval(coef3,mn:0.1:mx);
    plot(mn:0.1:mx,y3,'b')
    
     %   axis([0 10 0 0.04])
breakxaxis([31 189])
    ax = gca; %Then set the XTick property using dot notation, such as 
    ax.XTick = [0:1:10 20:20:320]
    
    %ax.XTickLabel = []
    ax.FontSize = 20;
    title('Vertebra Cell Density vs IVD:VB ratio')
    ylabel('Cell Density (cells/um^2)')
    xlabel('IVD/VB (um/um)')
%stop here to reposition axes, and make smaller or larger    %
% print('-dtiff',['density_vertebra_level_1_10_fit_allstages','.tif']);
% m00010('vertebral_density_ratio_1_10_fit_allstages_2')

    %% remake the vertebral_density_ratio plot to break the axis
    other_break = breakxaxis([31 189]) %h = breakxaxis([2 3]);
   
    %axis([190 320 0 0.04])
    w = gca;
    print('-dtiff',['density_vertebra_level_cut_x','.tif']);
    m00010('vertebral_density_ratio_cut_30_190_x')
    figure
   
    x = manualcell.IVD_over_VB_diameter;
    y = manualcell.density_VB;
    start = 50;
    stop = 150;
    width = 1;
  %leaves NaN for xtick folowing break h=BreakXAxis(x,y,start,stop,width)
  v = plot(manualcell.IVD_over_VB_diameter, manualcell.density_VB,'.')
    hold on
  
    axis([190 320 0 0.04])
    m00010('vertebral_density_ratio_high_x')


%% plot all the E14 vertebra density vs ratio
%fit line E14 data points
figure
    x_e14 = manualcell.IVD_over_VB_diameter((manualcell.Stage == 14));% & manualcell.IVD_over_VB_diameter <3)
    y_e14 = manualcell.density_VB((manualcell.Stage == 14));% & manualcell.IVD_over_VB_diameter <3)
    pl = plot(x_e14,y_e14*10,'r.')
%     hold on
%     x_e14 = manualcell.IVD_over_VB_diameter((manualcell.Stage == 14));% & manualcell.IVD_over_VB_diameter <3)
%     y_e14 = manualcell.Noto_VB_total((manualcell.Stage == 14));% & manualcell.IVD_over_VB_diameter <3)
%     plot(x_e14,y_e14,'b.')
    zx = gca;
    pl.MarkerSize = 20;
    zx.FontSize = 20;
    title('Vertebra Cell Density vs IVD:VB ratio, E14')
    ylabel('Cell Density (cells/um^2)')
    xlabel('IVD/VB (um/um)')

%stop here to reposition axes, and make smaller or larger    %
% print('-dtiff',['density_proliferation_vertebra_level_e14','.tif']);
% m00010('vertebral_density_proliferation_ratio_e14_2')
%% Figure 4B Percent Prolfierating Mitotic Index AF
daynames = ["E12.5" "E14.5" "E17.5"];
c = (manualcell.Level_number);
x = categorical(manualcell.Stage,[12,14,17],daynames);

level = discretize(manualcell.Level_number,[0 8 23 max(manualcell.Level_number)],'categorical',{'Cervical','Thoracic','Lumbar'});
summary(level);

y = manualcell.AF_pp;
%c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Annulus Fibrosus Percent Proliferation')
ylabel('Edu + / Total Cell')
td = gca;
td.YLim = [0 0.1800]

d = errorbar([median(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') median(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') median(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')],[std(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') std(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') std(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
%print('-dtiff',['AF_pp_longy','.tif']);
%m00010('AF_pp2')

median(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') 
median(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') 
median(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')
std(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') 
std(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') 
    std(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.AF_pp,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])


%% Figure 4C Percent Prolfierating Mitotic Index Notochord
%first the vertebra fragment, than the intervertebral expansion, for each
%timepoint




bb = figure;
mark = 12;%Marker size
embryo_logic =(manualcell.Stage == 12);
plot(1, manualcell.Noto_VB_percent_proliferating(embryo_logic),'r.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 12);
plot(2, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'r.','MarkerSize',mark)



embryo_logic =(manualcell.Stage == 14);
plot(3, manualcell.Noto_VB_percent_proliferating(embryo_logic),'g.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(4, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'g.','MarkerSize',mark)



embryo_logic =(manualcell.Stage == 17) & manualcell.Level_number <8;
plot(5, manualcell.Noto_VB_percent_proliferating(embryo_logic),'b.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(6, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'b.','MarkerSize',mark)

d = errorbar([median(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 12),'omitnan') median(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 12),'omitnan') median(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 14),'omitnan') median(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 14),'omitnan') median(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 17),'omitnan') median(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 17),'omitnan')],[std(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 12),'omitnan') std(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 12),'omitnan') std(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 14),'omitnan') std(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 14),'omitnan') std(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 17),'omitnan') std(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 1;
d.Color = [0 0 0];

 axis([0 7 0 (max(manualcell.Noto_IVD_percent_prolfierating) + 0.1*max(manualcell.Noto_IVD_percent_prolfierating))])
 axe = gca;
 axe.FontSize = 15;
 axe.LineWidth = 1.000;

 axe.XTick = [1 2 3 4 5 6]
 axe.XTickLabel = {'E12 Notochord VB Fragment' 'E12 Notochord Nucleus' 'E14 Notochord VB Fragment'  'E14 Notochord Nucleus' 'E17 Notochord VB Fragment'  'E17 Notochord Nucleus'}
hold off
title('Notochord Percent Proliferating');
ylabel('Number of Cells')
%stop and make plot area smaller be grabbing outside of box
% print('-dtiff',['notochord_prolfieration_20240329','.tif']);
% m00010('notochord_prolfieration_20240329')
median(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 12),'omitnan') 
median(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 14),'omitnan') 
median(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 17),'omitnan')

median(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 12),'omitnan') 
median(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 14),'omitnan') 
median(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 17),'omitnan')

std(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 12),'omitnan') 
std(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 14),'omitnan') 
std(manualcell.Noto_VB_percent_proliferating(manualcell.Stage == 17),'omitnan')

std(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 12),'omitnan') 
std(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 14),'omitnan') 
std(manualcell.Noto_IVD_percent_prolfierating(manualcell.Stage == 17),'omitnan')


figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.

% create one group per timepint ber region, every group on y axis is tested
% against each other. 
manualcell.e12_group = ones*(manualcell.Stage == 12);
e12_group = ones*(manualcell.e12_group);
e14_group = 2*ones*(manualcell.Stage == 14);
e17_group = 3*ones*(manualcell.Stage == 17);


temp_group1 = e12_group + e14_group + e17_group;
temp_group = [temp_group1; temp_group1+3]; %1 is E12 VVB percent proliferating, 2 is E12 IVD percent pro, 3 is E14 VB percent proliferating 4 is e!4 IVE pp 5 is E17 vb pp, 6 
Noto_VB_Noto_IVD_percent_pro = [manualcell.Noto_VB_percent_proliferating; manualcell.Noto_IVD_percent_prolfierating];


%!!!!!!!
% the order of groups for staistitics is e12 vb pp, e14 vb pp, e17 vb pp, 4 e12 ivd pp, 5 e14 ivd pp, 6 e17 ivd pp
% !!!!!!!!!!!!!!!!!
% [p,tbl,stats] = kruskalwallis(Noto_VB_Noto_IVD_percent_pro,temp_group,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.

[p,tbl,stats] = kruskalwallis(Noto_VB_Noto_IVD_percent_pro,temp_group,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])

%% Figure Percent Prolfierating all mesenchyme: vb and af

daynames = ["E12.5 VB" "E14.5 VB" "E17.5 VB"];
c = [manualcell.Level_number;manualcell.Level_number];
x = categorical(manualcell.Stage,[12,14,17],daynames);
daynames = ["E12.5 AF" "E14.5 AF" "E17.5 AF"];
x2 = categorical(manualcell.Stage,[12,14,17],daynames);
x_x = [x;x2]
y = [manualcell.VB_pp;manualcell.AF_pp];
daynames = ["E12.5" "E14.5" "E17.5"];

figure
s = swarmchart(x_x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Mesenchyme Percent Proliferation')
ylabel('Edu + / Total Cell')
td = gca;
%max prolfieraiton is 0.1765
td.YLim = [0 0.1900]

d = errorbar([median(manualcell.VB_pp(manualcell.Stage == 12),'omitnan') median(manualcell.VB_pp(manualcell.Stage == 14),'omitnan') median(manualcell.VB_pp(manualcell.Stage == 17),'omitnan') median(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') median(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') median(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')],[std(manualcell.VB_pp(manualcell.Stage == 12),'omitnan') std(manualcell.VB_pp(manualcell.Stage == 14),'omitnan') std(manualcell.VB_pp(manualcell.Stage == 17),'omitnan') std(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') std(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') std(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
print('-dtiff',['AF_pp_20240329','.tif']);
m00010('AF_pp_20240329')

median(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') 
median(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') 
median(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')
std(manualcell.AF_pp(manualcell.Stage == 12),'omitnan') 
std(manualcell.AF_pp(manualcell.Stage == 14),'omitnan') 
    std(manualcell.AF_pp(manualcell.Stage == 17),'omitnan')

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis([manualcell.VB_pp;manualcell.AF_pp],x_x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])


%% Figure 4D Percent Prolfierating Mitotic Index VB
daynames = ["E12.5" "E14.5" "E17.5"];
c = (manualcell.Level_number);
x = categorical(manualcell.Stage,[12,14,17],daynames);

level = discretize(manualcell.Level_number,[0 8 23 max(manualcell.Level_number)],'categorical',{'Cervical','Thoracic','Lumbar'});
summary(level);

y = manualcell.VB_pp;
%c = (manualcell.Level_number);
s = swarmchart(x,y,5,c,'filled');
hold on
s.SizeData = 20;
colormap(jet)
s.XJitterWidth = 0.5;
title('Vertebral Body Percent Proliferation')
ylabel('Edu + / Total Cell')
td = gca;
YLim_max = 1.1*max(manualcell.VB_pp);
td.YLim = [0 YLim_max]

d = errorbar([median(manualcell.VB_pp(manualcell.Stage == 12),'omitnan') median(manualcell.VB_pp(manualcell.Stage == 14),'omitnan') median(manualcell.VB_pp(manualcell.Stage == 17),'omitnan')],[std(manualcell.VB_pp(manualcell.Stage == 12),'omitnan') std(manualcell.VB_pp(manualcell.Stage == 14),'omitnan') std(manualcell.VB_pp(manualcell.Stage == 17),'omitnan')],'x')
d.LineWidth = 2;
d.Color = [0 0 0];


%stop and make plot area smaller be grabbing outside of box
print('-dtiff',['VB_pp_longy','.tif']);
m00010('VB_pp2')

median(manualcell.VB_pp(manualcell.Stage == 12),'omitnan') 
median(manualcell.VB_pp(manualcell.Stage == 14),'omitnan') 
median(manualcell.VB_pp(manualcell.Stage == 17),'omitnan')
std(manualcell.VB_pp(manualcell.Stage == 12),'omitnan') 
std(manualcell.VB_pp(manualcell.Stage == 14),'omitnan') 
    std(manualcell.VB_pp(manualcell.Stage == 17),'omitnan')

figure
%statistics
%Test the null hypothesis that the sample data from each column in x 
% comes from the same distribution. Suppress the output displays, 
% and generate the structure stats to use in further testing.
[p,tbl,stats] = kruskalwallis(manualcell.VB_pp,x,'off')
%compare each group
c = multcompare(stats);
%Display the multiple comparison results in a table.
tbl = array2table(c,"VariableNames", ...
    ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"])




%% new cell




%PLOT THE e12 vertebral area
    ii = 1
    for ii = 1:tt; 
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
    temp_x = 1*ones(1,length(manualcell.Dorsal_VB_Area(embryo_logic)))
    swarmchart(temp_x, manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    temp_x = 3*ones(1,length(manualcell.ventral_VB_Area(embryo_logic)))
    swarmchart(temp_x, manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E14 vertebral area
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        semilogy(3, manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(4, manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(5, manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(6, manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The area of Dorsal Vertebra (.) and Ventral Vertebra (o) vs Stage')
hold off
m00010('Vertebra Area E12, E14, E17')

%% plot the vertebral area vs level
manualcell.vertebra_area = manualcell.ventral_VB_Area + manualcell.Dorsal_VB_Area;
bb = figure;

embryo_logic =manualcell.Stage == 14;
plot(manualcell.Level_number(embryo_logic), manualcell.vertebra_area(embryo_logic),'g.')
hold on
embryo_logic =manualcell.Stage == 17;
plot(manualcell.Level_number(embryo_logic), manualcell.vertebra_area(embryo_logic),'b.')
embryo_logic =manualcell.Stage == 12;
plot(manualcell.Level_number(embryo_logic), manualcell.vertebra_area(embryo_logic),'r.')
hold off

%% 3D plot the vertebral area vs region (cervical, thoracic, lumbar)
manualcell.vertebra_area = manualcell.ventral_VB_Area + manualcell.Dorsal_VB_Area;
bb = figure;
mark = 12;%Marker size
embryo_logic =(manualcell.Stage == 12) & manualcell.Level_number <8;
plot(1, manualcell.vertebra_area(embryo_logic),'r.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 12) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(4, manualcell.vertebra_area(embryo_logic),'r.','MarkerSize',mark)
embryo_logic =(manualcell.Stage == 12) & (manualcell.Level_number >22);
plot(7, manualcell.vertebra_area(embryo_logic),'r.','MarkerSize',mark)

embryo_logic =(manualcell.Stage == 14) & manualcell.Level_number <8;
plot(2, manualcell.vertebra_area(embryo_logic),'g.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(5, manualcell.vertebra_area(embryo_logic),'g.','MarkerSize',mark)
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number >22);
plot(8, manualcell.vertebra_area(embryo_logic),'g.','MarkerSize',mark)

embryo_logic =(manualcell.Stage == 17) & manualcell.Level_number <8;
plot(3, manualcell.vertebra_area(embryo_logic),'b.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(6, manualcell.vertebra_area(embryo_logic),'b.','MarkerSize',mark)
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number >22);
plot(9, manualcell.vertebra_area(embryo_logic),'b.','MarkerSize',mark)
 axis([0 10 0 (max(manualcell.vertebra_area) + 0.1*max(manualcell.vertebra_area))])
 axe = gca;
 axe.FontSize = 15;
 axe.LineWidth = 1.000;
 axe.XTick = [1 2 3 4 5 6 7 8 9]
 axe.XTickLabel = {'E12 Cervical' 'E14 Cervical' 'E17 Cervical' 'E12 Thoracic' 'E14 Thoracic' 'E17 Thoracic' 'E12 Lumbar' 'E14 Lumbar' 'E17 Lumbar'}
hold off
title('Vertebra Size');
ylabel('Vertebra Area (um^2)')
%stop and make plot area smaller be grabbing outside of box
print('-dtiff',['vertebra_size_region','.tif']);
m00010('vertebra_size_region2')

%% 4F plot the vertebral percent proliferation vs region (cervical, thoracic, lumbar)
manualcell.vertebra_area = manualcell.ventral_VB_Area + manualcell.Dorsal_VB_Area;
bb = figure;
mark = 12;%Marker size
embryo_logic =(manualcell.Stage == 12) & manualcell.Level_number <8;
plot(1, manualcell.VB_pp(embryo_logic),'r.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 12) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(4, manualcell.VB_pp(embryo_logic),'r.','MarkerSize',mark)
embryo_logic =(manualcell.Stage == 12) & (manualcell.Level_number >22);
plot(7, manualcell.VB_pp(embryo_logic),'r.','MarkerSize',mark)

embryo_logic =(manualcell.Stage == 14) & manualcell.Level_number <8;
plot(2, manualcell.VB_pp(embryo_logic),'g.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(5, manualcell.VB_pp(embryo_logic),'g.','MarkerSize',mark)
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number >22);
plot(8, manualcell.VB_pp(embryo_logic),'g.','MarkerSize',mark)

embryo_logic =(manualcell.Stage == 17) & manualcell.Level_number <8;
plot(3, manualcell.VB_pp(embryo_logic),'b.','MarkerSize',mark)
hold on
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(6, manualcell.VB_pp(embryo_logic),'b.','MarkerSize',mark)
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number >22);
plot(9, manualcell.VB_pp(embryo_logic),'b.','MarkerSize',mark)
 axis([0 10 0 (max(manualcell.VB_pp) + 0.1*max(manualcell.VB_pp))])
 axe = gca;
 axe.FontSize = 15;
 axe.LineWidth = 1.000;
 axe.XTick = [1 2 3 4 5 6 7 8 9]
 axe.XTickLabel = {'E12 Cervical' 'E14 Cervical' 'E17 Cervical' 'E12 Thoracic' 'E14 Thoracic' 'E17 Thoracic' 'E12 Lumbar' 'E14 Lumbar' 'E17 Lumbar'}
hold off
title('Vertebra Proliferating');
ylabel('Vertebra proliferating')
%stop and make plot area smaller be grabbing outside of box
print('-dtiff',['vertebra_pp_region','.tif']);
m00010('vertebra_pp_region2')

%% plot the percent proliferating in AF vs region (cervical, thoracic, lumbar)

%moved to beginning of document manualcell.AF_pp = (manualcell.Dorsal_AF_Edu+ manualcell.Ventral_AF_Edu)./(manualcell.Dorsal_AF_Total+manualcell.Ventral_AF_Total);
bb = figure;
embryo_logic =(manualcell.Stage == 12) & manualcell.Level_number <8;
plot(1, manualcell.AF_pp(embryo_logic),'r.')
hold on
embryo_logic =(manualcell.Stage == 12) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(2, manualcell.AF_pp(embryo_logic),'r.')
embryo_logic =(manualcell.Stage == 12) & (manualcell.Level_number >22);
plot(3, manualcell.AF_pp(embryo_logic),'r.')

embryo_logic =(manualcell.Stage == 14) & manualcell.Level_number <8;
plot(4, manualcell.AF_pp(embryo_logic),'g.')
hold on
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(5, manualcell.AF_pp(embryo_logic),'g.')
embryo_logic =(manualcell.Stage == 14) & (manualcell.Level_number >22);
plot(6, manualcell.AF_pp(embryo_logic),'g.')

embryo_logic =(manualcell.Stage == 17) & manualcell.Level_number <8;
plot(7, manualcell.AF_pp(embryo_logic),'b.')
hold on
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number <23 & manualcell.Level_number >7);
plot(8, manualcell.AF_pp(embryo_logic),'b.')
embryo_logic =(manualcell.Stage == 17) & (manualcell.Level_number >22);
plot(9, manualcell.AF_pp(embryo_logic),'b.')

 
hold off

%% plot the E14 sample by name with large AF against ventral Af
name = "20211116_e14_T3_T8";
for ii = 1:size(manualcell)[1]
if contains(string(manualcell.Image_Name(ii)), "20211116_e14_T3_T8")
    plot(1, manualcell.Dorsal_VB_Area(ii),'r.')
    plot(1, manualcell.ventral_VB_Area(ii),'b.')
    plot(2, manualcell.Dorsal_AF_Area(ii),'r.')
    plot(2, manualcell.Ventral_AF_area(ii),'b.')
    hold on
end
end
hold off
%title(string([name,'vb_af_area'])
m00010('20231208_e14_T3_T8_vb_af_area')
%% plot the AF prolfeiration by level
manualcell.noto_mit = (manualcell.Noto_IVD_percent_prolfierating + manualcell.Noto_VB_percent_proliferating)./2
bb = figure;
embryo_logic =manualcell.Stage == 14;
plot(manualcell.IVD_over_VB_diameter(embryo_logic), manualcell.noto_mit(embryo_logic),'k.')
hold on
plot(manualcell.IVD_over_VB_diameter(embryo_logic), manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'r.')
title('black average, red IVD')
hold off

plot(manualcell.IVD_over_VB_diameter, manualcell.Noto_IVD_percent_prolfierating,'g.')

%% a plot
    %subplot(2,2,1)
    hold on
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(manualcell.Level_number(embryo_logic), manualcell.Intervertebral_Disc(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        %hold off
    end
   
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(manualcell.Level_number(embryo_logic), manualcell.Vertebral_Body(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    title('The mitotic index of Intervertebral Expansion (.) and Vertebral Fragment (o) vs Level number')
    hold off

    subplot(2,2,2)
    hold on
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(manualcell.IVD_over_VB_diameter(embryo_logic), manualcell.Intervertebral_Disc(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(manualcell.IVD_over_VB_diameter(embryo_logic), manualcell.Vertebral_Body(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    title('The mitotic index of Intervertebral Expansion (.) and Vertebral Fragment (o) vs IVD:VB Diameter')

    subplot(2,2,3)
    hold on
    ii = 1
   
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(manualcell.Level_number(embryo_logic), manualcell.sum_volue_one_segment(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    title('The Notochord Volume vs Level number')

    hold off

    subplot(2,2,4)
    hold on
    ii = 1
    
   
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(manualcell.sum_volue_one_segment(embryo_logic), (manualcell.Noto_Edu(embryo_logic)+manualcell.Noto_Inferior_VB_Edu(embryo_logic)),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    title('The Number of Proliferating Cells vs Volume')
%manualcell.VariableNames


%histogram
% edges=[1 7 20 27 37];
%    [~,~,bin] = histcounts(manualcell.Level_number,edges);
%    X=edges(bin)
%%%%%%%%%%%%%%%%%%%%%
%% plot the total number of dividing cells NOTOCHORD vertebral vs intervertebral 
figure
%axis([0 6 0 1])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:tt;%max(manualcell.embryo_number);
        ii
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(1, manualcell.Noto_IVD_Edu(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;%max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(2, manualcell.Noto_VB_Edu(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        plot(3, manualcell.Noto_IVD_Edu(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(4, manualcell.Noto_VB_Edu(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(5, manualcell.Noto_IVD_Edu(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(6, manualcell.Noto_VB_Edu(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The proliferating cell number of Intervertebral Expansion (.) and Vertebral Fragment (o) vs Stage')
hold off
%m00010('mitotic_index_Notochord_e12_e14_e17')

%% plot the NOTOCHORD vertebral vs intervertebral mitotic indices
figure
axis([0 6 0 1])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:tt;%max(manualcell.embryo_number);
        ii
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(1, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;%max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(2, manualcell.Noto_VB_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the  E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        plot(3, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(4, manualcell.Noto_VB_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(5, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(6, manualcell.Noto_VB_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The mitotic index of Intervertebral Expansion (.) and Vertebral Fragment (o) vs Stage')
hold off
%m00010('mitotic_index_Notochord_e12_e14_e17')


%% plot the AF ventral & dorsal mitotic indices
figure
%axis([0 6 0 0.3])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(1, manualcell.Dorsal_AF_percent_proliferating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(2, manualcell.Ventral_AF_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the   E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        plot(3, manualcell.Dorsal_AF_percent_proliferating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(4, manualcell.Ventral_AF_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(5, manualcell.Dorsal_AF_percent_proliferating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(6, manualcell.Ventral_AF_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The mitotic index of Dorsal AF (.) and Ventral AF (o) vs Stage')
hold off
m00010('mitotic_index_AF_e12_e14_e17_20231017')

%% plot the vertebral mitotic indices
figure
axis([0 6 0 0.3])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:tt;
        embryo_logic =  manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(1, manualcell.Dorsal_VB_percent_proliferating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;
        embryo_logic =  manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(2, manualcell.ventral_vb_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the   E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        plot(3, manualcell.Dorsal_VB_percent_proliferating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(4, manualcell.ventral_vb_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(5, manualcell.Dorsal_VB_percent_proliferating(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(6, manualcell.ventral_vb_percent_proliferating(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The mitotic index of Dorsal Vertebra (.) and Ventral Vertebra (o) vs Stage')
hold off
m00010('mitotic_index_Vertebra_e12_e14_e17')

%% plot the vertebral area
figure
axis([0 6 0 140000])
hold on
%PLOT THE e12 vertebral area
    ii = 1
    for ii = 1:tt; 
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
    temp_x = 1*ones(1,length(manualcell.Dorsal_VB_Area(embryo_logic)))
    plot(temp_x, manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(2, manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the  E14 vertebral area
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        semilogy(3, manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(4, manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(5, manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(6, manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The area of Dorsal Vertebra (.) and Ventral Vertebra (o) vs Stage')
hold off
m00010('Vertebra Area E12, E14, E17')
%% plot the annulus area
figure
axis([0 7 0 16000])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(1, manualcell.Dorsal_AF_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(2, manualcell.Ventral_AF_area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the   E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        semilogy(3, manualcell.Dorsal_AF_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(4, manualcell.Ventral_AF_area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(5, manualcell.Dorsal_AF_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(6, manualcell.Ventral_AF_area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The area of Dorsal Annulus (.) and Ventral Annulus (o) vs Stage')
hold off
m00010('Annulus Area E12, E14, E17')

%% plot the notochord area
figure
%axis([0 6 0 10000])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(1, manualcell.Noto_IVD_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(2, manualcell.Noto_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        semilogy(3, manualcell.Noto_IVD_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(4, manualcell.Noto_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(5, manualcell.Noto_IVD_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(6, manualcell.Noto_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The area of Notochord fragment Vertebra (.) and Intervertebra (o) vs Stage')
hold off
m00010('Notochord Area E12, E14')


%% plot the total mesenchymal segment area (not notochord, yes vertebra and  AF)
figure
axis([0 7 0 400000])
hold on
manualcell.total_mesenchyme_area = manualcell.Dorsal_AF_Area+manualcell.Ventral_AF_area+ manualcell.Dorsal_VB_Area + manualcell.ventral_VB_Area;
%PLOT THE e12 areas
    ii = 1
    for ii = 1:tt;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(1, manualcell.total_mesenchyme_area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    
    % plot all the  E14 total area
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        semilogy(3, manualcell.total_mesenchyme_area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    
    % plot all the E17 total area
    ii = 1
    for ii = 1:ss;
        embryo_logic = manualcell.embryo_number==ii & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(5, manualcell.total_mesenchyme_area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
   
    
title('The area of Annulus and Vertebra vs Stage')
hold off
m00010('Total segment Area E12, E14, E17')
%% plot the vertebral body density
figure
axis([0 6 0 0.04])
hold on
%PLOT THE e12 INDICES
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(1, manualcell.Dorsal_VB_total(embryo_logic)./manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.Stage == 12;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(2, manualcell.Ventral_VB_total(embryo_logic)./manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the   E14 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14);
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
        semilogy(3, manualcell.Dorsal_VB_total(embryo_logic)./manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
        
        ii = ii+1
        fprintf('doing')
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(4, manualcell.Ventral_VB_total(embryo_logic)./manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    % plot all the E17 mitotic indices
    ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==1 & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(5, manualcell.Dorsal_VB_total(embryo_logic)./manualcell.Dorsal_VB_Area(embryo_logic),'.','Color',colorstring(ii))
    
        ii = ii+1
        clear embryo_logic
        hold on
    end
        ii = 1
    for ii = 1:max(manualcell.embryo_number);
        embryo_logic = manualcell.embryo_number==1 & manualcell.Stage == 17;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    semilogy(6, manualcell.Ventral_VB_total(embryo_logic)./manualcell.ventral_VB_Area(embryo_logic),'o','Color',colorstring(ii))
        ii = ii+1
        clear embryo_logic
        hold on
    end
    
    title('The density of Dorsal vertebra (.) and Ventral vertebra (o) vs Stage')
hold off
m00010('Vertebra Density E12, E14, E17')


    %% plot categorical variables 
    %E14 mitotic index cervical ivd expansion, E14 MI cervical vb
    %expansion, thoracic, lumbar
    figure
    histogram(manualcell.Vertebral_Body)
    figure
    histogram(manualcell.Level_number)
    m00010('histogram_e14_bylevel') %[TODO] this doesn't work yet. m00003 just prints text doc to matlabplots folder (where m000003 is)
%addpath C:/Users/Rose/Desktop/aa123rose/matlabplots

%% plot E14
% plot all the  E14 mitotic indices
figure
hold on
clear embryo_logic
   
        embryo_logic = manualcell.Stage == 14;
        
        plot(3, manualcell.Noto_IVD_percent_prolfierating(embryo_logic),'.')
        
        hold on
    %embryo_logic = manualcell.embryo_number==ii & (manualcell.Stage == 14) ;
        colorstring = 'kgryb';
    %plot(manualcell(:,6), manualcell(:,27),'.')
        
    plot(4, manualcell.Noto_VB_percent_proliferating(embryo_logic),'o')
       
