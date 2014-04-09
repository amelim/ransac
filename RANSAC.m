function RANSAC(P, nrIterations)
  solutionInliers = [];
  bestError = Inf;
  
  filename = 'ransac.gif';
  
  for k = 1:nrIterations
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1;
        imwrite(imind,cm,filename,'gif','DelayTime',0.1,'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','DelayTime',0.01,'WriteMode','append');
    end
    
    %% RANSAC
    nrPoints = length(P);

    % Sample
    samples = datasample(P,2); % Sample w/o replacement

    p1 = samples(1,:);
    p2 = samples(2,:);

    ph1 = plot(p1(1),p1(2),'bo', 'MarkerSize',15)
    ph2 = plot(p2(1),p2(2),'bo', 'MarkerSize',15)

    % Solve for parameters
    m = (p2(2) - p1(2))/(p2(1)-p1(1));
    b = p1(2) - m*p1(1);

    Ps = [];

    % Plot line for visualization
    for x=-20:0.5:20
      y = m*x + b;
      Ps = [Ps; x,y];
    end
    lh = line(Ps(:,1),Ps(:,2),'color','r')

    % Threshold
    delta = 3;

    % Score
    pH = []; %Handles for inliers
    inliers = [];
    error = 0;
    for i = 1:nrPoints

      x = P(i,1);
      y = P(i,2);
      h = plot(x,y,'ro', 'MarkerSize',15);
      
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      imwrite(imind,cm,filename,'gif','DelayTime',0.01,'WriteMode','append');
      
      % Find the distance to the line
      dist = abs(y - m*x - b)/sqrt(1 + m^2); 

      % If the distance is less than our threshold
      if(dist < delta)
        % Add to the inlier set
        inliers = [inliers; x y];
        ha = plot(x,y,'g*');
        pH = [pH; ha];
      else
        % Add to the total error
        error = error + dist;
        ha = plot(x,y,'r*');
        pH = [pH; ha];
      end
      
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      imwrite(imind,cm,filename,'gif','DelayTime',0.01,'WriteMode','append');
      
      delete(h)
    end
    
    if(error < bestError)
      solutionInliers = inliers;
      bestError = error
    end

    delete(pH);
    delete(lh);
    delete(ph1);
    delete(ph2);
  end
  
  %Plot solution
  for i = 1:length(solutionInliers)
    x = solutionInliers(i,1);
    y = solutionInliers(i,2);
    h = plot(x,y,'go', 'MarkerSize',15);
  end
  frame = getframe(1);
  im = frame2im(frame);
  [imind,cm] = rgb2ind(im,256);
  imwrite(imind,cm,filename,'gif','WriteMode','append');
end