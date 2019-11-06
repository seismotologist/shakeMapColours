clear all
addpath(genpath('~/programs/seismo/matlab/base/m_plot/colour/'))
% This is an attempt to understand how to plot matlab colourbars using the 
% USGS ShakeMap colourmap. Its... surprisingly complicated. Please let me 
% know if you have a better solution. 
% mmeier@caltech.edu, 191105

% Depending on the type of plot you are making you have to proceed in
% slightly different ways: 
% 1. Colourbar for independently drawn lines and points
% 2. Colourbar for scatter, surface and image plots



%% 1. Colourbar for independently drawn lines and points
% shakeMap_cscale.m samples the ShakeMap colour scale for any vector of mmi 
% values
mmi    = 1:10;
cscale = shakeMap_cscale(mmi);

% Create 10 lines, one for each mmi value; plot and colour them with 
% shakeMap colour map
t    = (0:.1:5)';
nt   = numel(t);
exp  = 2.1:.1:3;
nexp = numel(exp);

clf; hold on; grid on; box on;
for iexp = 1:nexp
    y = t.^exp(iexp);
    plot(t,y,'color','k'              ,'lineWidth',3)
    plot(t,y,'color',cscale.map(iexp,:),'lineWidth',2)
end

% We can use cascale to add a colour bar but we need to set ticks and 
% labels manually
cb = colorbar;
colormap(cscale.map)
cb.Label.String = 'MMI';
cb.Ticks        = cscale.Ticks;
cb.TickLabels   = cscale.TickLabels;


% We can also use differnet minimum and maximum MMI levels, like so
clear cb cscale
mmi    = linspace(3,10,8);
cscale = shakeMap_cscale(mmi);

cb = colorbar;
colormap(gcf,cscale.map); 
cb.Label.String = 'MMI';
cb.TickLabels   = cscale.TickLabels;
cb.Ticks        = cscale.Ticks;



%% 2. Colourbar for scatter, surface and image plots

% Plot e.g. MMI scatter plot 
x   = (0.2:.2:10.4);  %x = (2.2:.2:8.4);
y   = x;
mmi = x;
n   = numel(x);

clf; hold on; grid on; box on;
scatter(x,y,50*ones(n,1),mmi,'filled','markerEdgeColor','k')
set(gca,'xtick',1:1:10,'ytick',1:1:10,'xlim',[0 11],'ylim',[0 11])

% In this case the colourmap of both the displayed points and the colourbar
% are directly linked. You can control the mapping with caxis. 
cscale = shakeMap_cscale;
cb     = colorbar;
colormap(cscale.map);
caxis([.5 10.5])
cb.Label.String = 'MMI';





%% The colourbar colours are now directly tied to the colours in the map. So
% if you change the colourbar range, e.g. with caxis, the data points 
% change colours:
caxis([2 7])

% So, don't do it! Change it back to the true range of the colourmap
caxis([.5 10.5])

% This was surprisingly complicated. Do you know a better solution? Please 
% do let me know. Cheers!