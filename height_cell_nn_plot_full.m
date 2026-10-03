% Rose Long
% august 8, 2024
% 1) plot height versus radius change, 
% see if height increases as radius decreases
% 2) given xy coordinate from qupath, density of cells 
%saved matrix ce as imported data from:
% image 20210915_e14_L3_ - Stitched.nd2 - 20210915_e14_L3_ - Stitched.nd2 (series 1)
%% plot diameter vs height awith line for constant height
%line for constant volume
%shaded line captures almost all the points
figure
set(gca,'FontSize',20);
set(gca,'DefaultLineLineWidth',100)
hold on
%disp(tb_test_a(tb_test_a.col123==0.4,:));, to select a row with String =
%column select the rows where Var1="b"
%disp(tb_test_a(strcmp(tb_test_a.Var1, "b"),:));

manualcell14 = manualcell(manualcell.Stage == 13 | manualcell.Stage == 14, :);
pl = plot(manualcell14.Notochord_InferiorVB_diameter,manualcell14.Height_Notochord_Inferior_Vertebra,'b.')
pl.MarkerSize = 10;
title('Notochord Geometry at Vertebra, E14.5')
%estimated volume (at diameter of 30) 
median_diameter = median(manualcell14.Notochord_InferiorVB_diameter, 'omitnan')% = 100;
median_h = median(manualcell14.Height_Notochord_Inferior_Vertebra,'omitnan')
v_est = pi()*(median_diameter/2)^2 * median_h;

%make diameter vecotr from min to max
minn = 10.9; %12.6 for y = 350
maxx = max(manualcell14.Notochord_InferiorVB_diameter);
diameter_vect = minn:0.1:maxx;

calc_height = v_est./(pi().*(diameter_vect./2).^2);
zz = plot(diameter_vect,calc_height,'r.')
zz.MarkerSize = 10;
calc_height = v_est./(pi().*(manualcell14.Notochord_InferiorVB_diameter./2).^2);
t = isnan(manualcell14.Height_Notochord_Inferior_Vertebra) |isnan(calc_height);
v = ~t;
nan_height = manualcell14.Height_Notochord_Inferior_Vertebra(v);
nan_calc_height = calc_height(v);
nan_diameter = manualcell14.Notochord_InferiorVB_diameter(v);
mdl_real_data = fitlm(nan_diameter, nan_height)%last variable is response
%fit 2nd degree polynomial to constant volume calculated hieght
[coef3, mdl_constant_volume] = polyfit(nan_diameter, nan_calc_height,5)%last variable is response
mn = min(nan_diameter);
mx = max(nan_diameter);
y3 = polyval(coef3,mn:0.1:mx);
%plot(mn:0.1:mx,y3,'r.')
%fit linear polynomial to actual height
[coef3, mdl_constant_volume] = polyfit(nan_diameter, nan_height,1)%last variable is response
mn = min(nan_diameter);
mx = max(nan_diameter);
y3 = polyval(coef3,mn:0.1:mx);
plot(mn:0.1:mx,y3,'g.')
set(gco,'MarkerSize',10)
R_squared_linear = 1 - (mdl_constant_volume.normr/norm(nan_height - mean(nan_height)))^2
ylabel('Notochord Height (um)')
xlabel('Notochord Diameter (um)')
ylim([0 350])
xlim([0 1.1*mx])


m00010('E14_DiametervsHeight_yellowconstantvolumemedianhtrad_green_linearfit3')
%Rsquared is 0.0904. 
% 
%plot(line(manualcell.Notochord_InferiorVB_diameter,calc_height))

% %select the matrix entry that are vector
% %remove the nan
% 
% % i = isnan(x_e14);
% % x_e14(i) = []
% % 
% i = isnan(manualcell14.Height_Notochord_Inferior_Vertebra) |isnan(manualcell14.Notochord_InferiorVB_diameter);
% j = ~i;
% %!!!!!!!!!!!!!!!!!!
% %I renamed this variable with all that are number, exclude NaN
% % zHeight_Notochord_Inferior_Vertebra = manualcell14.Height_Notochord_Inferior_Vertebra;
% % zNotochord_InferiorVB_diameter = manualcell14.zNotochord_InferiorVB_diameter;
% zHeight_Notochord_Inferior_Vertebra(i) = manualcell14.Height_Notochord_Inferior_Vertebra(j);
% zNotochord_InferiorVB_diameter(i) = manualcell14.Height_Notochord_Inferior_Vertebra(j);

% %add fitline
% %degree polynomial to fit:
% zz = 5;
% [coef3,S] = polyfit(zNotochord_InferiorVB_diameter,zHeight_Notochord_Inferior_Vertebra,zz) %
% S.R;
% R_squared = 1 - (S.normr/norm(zHeight_Notochord_Inferior_Vertebra - mean(zHeight_Notochord_Inferior_Vertebra)))^2
% mn = min(zNotochord_InferiorVB_diameter);
% mx = max(zNotochord_InferiorVB_diameter);
% y3 = polyval(coef3,mn:0.1:mx);
% plot(mn:0.1:mx,y3,'y.')

% %degree polynomial to fit:
% zz = 2;
% [coef3,S] = polyfit(zNotochord_InferiorVB_diameter,zHeight_Notochord_Inferior_Vertebra,zz) %
% S.R;
% R_squared = 1 - (S.normr/norm(zHeight_Notochord_Inferior_Vertebra - mean(zHeight_Notochord_Inferior_Vertebra)))^2
% mn = min(zNotochord_InferiorVB_diameter);
% mx = max(zNotochord_InferiorVB_diameter);
% y3 = polyval(coef3,mn:0.1:mx);
% plot(mn:0.1:mx,y3,'g.')


%% 2 plot cells 
%7th column in x centroid, 8th column ins y centroid 
figure
tic
plot(ce.CentroidXm, ce.CentroidYm,'r.')
title('the cells from semivertebra')
toc
%plots all the dots from the within the parent object. 
%1) assign objects to class vertebra, then export, select with tag
%problem: multiple vertebra per image
%2) just create heatmap based on all the cells, then try to subset out roi,
%dont want to have to plot over original image? 
%but then, will have all cells in subset which is too many
%could add annotations so that regions are preserved, can could be called
%in matlab to compute
%then could calculate nn per region
%try to subset by annotation, and plot heatmap
%set vertebra annotations to class vertebra, the export to C:/Users/Rose/Desktop/My_detections_vertebra_marked.txt

%did not work, all cell detections under original outline parent.
%could troubleshoot assigning detections to annotation
% qupath also has measurement maps for density, maybe I should go there
% figure
tic
plot(ce_vert.CentroidXm, ce_vert.CentroidYm,'r.')
title('the cells from semivertebra')
toc
tic
%% using density plot function
% figure
% get dimensions 
x_length = sqrt(max(e17.CentroidXm)^2-min(e17.CentroidXm)^2);
y_length = sqrt(max(e17.CentroidYm)^2-min(e17.CentroidYm)^2);
%changing the number of bins changes the density 
% the density is given in points/bin, I think
%so to get cells/100cubic microns, have to makes bins 10um in x and y
%dimension
%get x dimension in microns, and give x/10 number of bins,
%need to know if centroids are given in pixel or micron from qupath
%make the color bar units of density choose 10 for cells/100sq microns
tt = 10;
x_normlength = round(x_length/tt);
y_normlength = round(y_length/tt);

%hist3(X,[7 7]); make a plot on a 7x7 grid of bins. 
densityplot(e17.CentroidXm, e17.CentroidYm,[x_normlength,y_normlength])

%make multiple plots have the same max density
% A= [ 1 2 3 4; 5 6 7 8; 9 10 11 12]
% B = mat2cell(A,[1 1 1],[2 2])
% celldisp(B)
%CTRS = {} %two element cell array, with each element a vector of centers (0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5)

% figure
% densityplot(td.CentroidXm, td.CentroidYm,[x_normlength,y_normlength],)
set(gca, 'XDir','reverse')%if flipped aorund y: set(gca, 'YDir','reverse')
set(gca, 'XTickLabel',[])
set(gca, 'YTickLabel',[])
%[xflip, yflip] = flip([ce_vert.CentroidXm, ce_vert.CentroidYm],2);
% figure
% densityplot(Aa,[50,50])
% densityplot(Aa,[50,50],'Ctrs',CTRS)
% where CTRS is a two-element cell array of numeric
%     vectors with monotonically non-decreasing values, uses a 2D grid of
%     bins centered on CTRS{1} in the first dimension and on CTRS{2} in the
%     second, here x and y , each dimension are the same (density, so centers are same). 
%this image is flipped along y axis compared to qupath image


