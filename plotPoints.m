function plotPoints(P)
  %% PLOTPOINTS
  % Simple plotting script for a list of 2D points
  figure;

  for i=1:length(P)
    plot(P(i,1),P(i,2),'*', 'color', [0.5000    0.5000    1.0000])
    hold on;
  end
  axis([-80 80 -80 80])
end
