%Define the input DataSet
q_i1=linspace(-0.35,0.35,20);q_f1=linspace(0.35,-0.35,20);
q_i2=linspace(1.57,0,20);q_f2=linspace(0,1.57,20);
q_i3=linspace(0,1.57,20);q_f3=linspace(1.57,0,20);

qi1=linspace(0.35,0.35,10);qf1=linspace(0.33,-0.35,10);
qi2=linspace(1.57,0,10);qf2=linspace(0,1.57,10);
qi3=linspace(0,1.57,10);qf3=linspace(1.57,0,10);

qri1=linspace(-0.35,-0.35,10);qrf1=linspace(-0.34,0.35,10);
qri2=linspace(1.57,1.57,10);qrf2=linspace(0.13,1.56,10);
qri3=linspace(0.12,1.562,10);qrf3=linspace(1.57,1.57,10);

q1_initial=[linspace(-0.35,-0.15,5) linspace(0.35,0.09,5) linspace(0,0,5) linspace(0,0,5) q_i1 qi1 qri1];
q1_final=[linspace(0,0,5) linspace(0,0,5) linspace(-0.12,-0.35,5) linspace(0.35,0.095,5) q_f1 qf1 qrf1];

q2_initial=[linspace(0,0,10) linspace(1.54,0.16,10) q_i2 qi2 qri2];
q2_final=[linspace(0.13,1.54,10) linspace(0,0,10) q_f2 qf2 qrf2];

q3_initial=[linspace(0,1.57,10) linspace(0,0,10) q_i3 qi3 qri3];
q3_final=[linspace(0,0,10) linspace(1.56,0.159,10) q_f3 qf3 qrf3];

% Define the number of runs
numRuns = 60;

% Loop to run the simulation multiple times
for i = 1:numRuns

   open("FromMatlabModelpulley4422datacollectionpd3inertia.slx")
    mdl="FromMatlabModelpulley4422datacollectionpd3inertia";
  
    simin = Simulink.SimulationInput(mdl);
    simin=setBlockParameter(simin,'FromMatlabModelpulley4422datacollectionpd3inertia/Constant1',Value='q1_initial(1,i)');
    simin=setBlockParameter(simin,'FromMatlabModelpulley4422datacollectionpd3inertia/Constant2',Value='q2_initial(1,i)');
    simin=setBlockParameter(simin,'FromMatlabModelpulley4422datacollectionpd3inertia/Constant3',Value='q3_initial(1,i)');
    simin=setBlockParameter(simin,'FromMatlabModelpulley4422datacollectionpd3inertia/Constant4',Value='q1_final(1,i)');
    simin=setBlockParameter(simin,'FromMatlabModelpulley4422datacollectionpd3inertia/Constant5',Value='q2_final(1,i)');
    simin=setBlockParameter(simin,'FromMatlabModelpulley4422datacollectionpd3inertia/Constant6',Value='q3_final(1,i)');

    % Run the simulation
    out(i) = sim(simin);
   
end

% Data writing on a text file 

tf=10;
dt=0.01;
t=0:dt:tf;

fid3=fopen('datacollectionnew/datacollection_thumb_autott.txt','a');
fid4=fopen('datacollectionnew/datacollection_index_autott.txt','a');

for j=1:60
for i=1:length(t)
fprintf(fid3,'%.5f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f\r\n',t(i),out(1,j).q_d1(i),out(1,j).q_d2(i),out(1,j).q_d3(i),out(1,j).q_m1(i),out(1,j).q_m2(i),out(1,j).q_m3(i),out(1,j).q_dot_m1(i),out(1,j).q_dot_m2(i),out(1,j).q_dot_m3(i),out(1,j).tau_m1(i),out(1,j).tau_m2(i),out(1,j).tau_m3(i));
fprintf(fid4,'%.5f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f %.7f\r\n',t(i),out(1,j).q_d1f2(i),out(1,j).q_d2f2(i),out(1,j).q_d3f2(i),out(1,j).q_m1f2(i),out(1,j).q_m2f2(i),out(1,j).q_m3f2(i),out(1,j).q_dot_m1f2(i),out(1,j).q_dot_m2f2(i),out(1,j).q_dot_m3f2(i),out(1,j).tau_m1f2(i),out(1,j).tau_m2f2(i),out(1,j).tau_m3f2(i));
end
end
