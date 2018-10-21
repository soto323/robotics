%% Solving the inverse problem
% Represent a given rotation matrix as a sequence of three ZXZ Euler angles

% Input

% R=input('Enter a 3x3 rotation matrix: ');

% R=[ 0.4330   -0.5      -0.75;
%      0.25      0.8660   -0.4330;
%      0.8660    0         0.5   ];

% R=[ 0.5950     0.5403     0.5950;
%     -0.3821    -0.8415    -0.3821;
%     -1/sqrt(2)  0          1/sqrt(2)];

R=[-1/sqrt(2)   -1/sqrt(2)   0;
     1/sqrt(2)   -1/sqrt(2)   0;
     0               0        1];

% Verify that R belongs to SO(3)
[m n]=size(R);
if m~=3||n~=3
    error('Enter a 3x3 matrix and try again')
end
d=det(R);

r1=R(:,1);
r2=R(:,2);
r3=R(:,3);

a=r1'*r2;
b=r2'*r3;
c=r3'*r1;

if  ~((0.999<d<1.001)&&(-1e-3<a)&&(a<1e-3)&&(-1e-3<b)&&(b<1e-3)&&(-1e-3<c)&&(c<1e-3))
    fprintf('det(R)= ')
    disp(d)
    fprintf("r1'*r2= ")
    disp(a)
    fprintf("r2'*r3= ")
    disp(b)
    fprintf("r3'*r1= ")
    disp(c)
    error('The matrix is not a rotation matrix, try again')
end
Y=sqrt(R(1,3)^2+R(2,3)^2);
X=R(3,3);

% Calculate the two possible values of theta
theta1=atan2(Y,X);
theta2=atan2(-Y,X);
if theta1~=0 && theta2~=0
    % Calculate the two possible values of psi
    psi1=atan2(R(3,1)/sin(theta1),R(3,2)/sin(theta1));
    psi2=atan2(R(3,1)/sin(theta2),R(3,2)/sin(theta2));

    % Calculate the two possible values of phi
    phi1=atan2(R(1,3)/sin(theta1),-R(2,3)/sin(theta1));
    phi2=atan2(R(1,3)/sin(theta2),-R(2,3)/sin(theta2));
    
    % Output
    fprintf('The two possible sets of ZXZ Euler angles are: ')
    % In radians
    ZXZ1=[phi1 theta1 psi1]
    ZXZ2=[phi2 theta2 psi2]
    % In degrees
    % ZXZ1=[theta1 psi1 phi1]*180/pi
    % ZXZ2=[theta2 psi2 phi2]*180/pi
else
    phi=atan2(R(2,1),R(1,1));
    fprintf('The rotation around the X axis is 0 and the total rotation around the Z axis is ')
    disp(phi);
    % In degrees
    % disp(phi*180/pi);
end
