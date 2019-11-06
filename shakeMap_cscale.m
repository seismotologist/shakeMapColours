function cscale = shakeMap_cscale(mmi)
% Returns re-sampled ShakeMap MMI colour map for any vector of mmi values.
% Without input arguments it returns standard scale. The colours returned 
% in cscale.map are the colour values of the bin centers, rather than bin 
% edges.
% 
% mmeier@caltech.edu, 191105

if nargin<1; mmi = 1:10; end
nc = numel(mmi);

% The colours in the original colour map are the colours of the 11 edges of
% the 10 bins, evenly spaced from 0.5 to 10.5
cmap = 1/255*[255 255 255
              191 204 255
              160 230 255
              128 255 255
              122 255 147
              255 255 0
              255 200 0
              255 145 0
              255 0 0
              200 0 0
              128 0 0];
           
% Not sure why this is ncessary but it works...
mmiVal = (0:10)+1;

cscale.map      = zeros(nc,3);
cscale.map(:,1) = interp1(mmiVal,cmap(:,1),mmi,'linear');
cscale.map(:,2) = interp1(mmiVal,cmap(:,2),mmi,'linear');
cscale.map(:,3) = interp1(mmiVal,cmap(:,3),mmi,'linear');

dy                = 1/nc;
cscale.Ticks      = dy/2:dy:((nc-1)*dy+dy/2);
cscale.TickLabels = mmi;
cscale.mmi        = mmi;