function leastsquares(P)
  %% Least Squares fit
  % E = sum(y-mx-b)^2
  % Find m,b to minimize E
  % XB = Y

  X = [P(:,1) ones(length(P),1)];
  Y = P(:,2);
  B = inv(X' * X)*X' * Y;
  
  m=B(1);
  b=B(2);
  % Data points
  Ps = [];

  for x=-20:0.5:20
    y = m*x + b;
    Ps = [Ps; x,y];
  end
  line(Ps(:,1),Ps(:,2),'color','r')
end
