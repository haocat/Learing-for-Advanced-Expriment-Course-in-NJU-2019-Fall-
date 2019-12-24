ORDER = 9;
N = 511 ;  % code length
K = 484 ;  % information bits
M = N - K ; % check bits

genpoly = bchgenpoly(2^ORDER-1,2^ORDER-1-M);
max_err = bchnumerr(2^ORDER-1,2^ORDER-1-M);



SIGMA_BCH = [0.405, 0.4025, 0.4, 0.3975, 0.395, 0.3925, 0.39, 0.3875, 0.385, 0.38];
SIGMA_BCH1 = [0.405, 0.4025, 0.4, 0.3975, 0.395, 0.3925, 0.39, 0.3875, 0.385, 0.38];

RBER_BCH = 1-normcdf(0, -1, SIGMA_BCH);
RBER_BCH1 = 1-normcdf(0, -1, SIGMA_BCH);
FER_BCH = 1 - binocdf(max_err,N,RBER_BCH);   
FER_NONE = 1 - binocdf(0,N,RBER_BCH1);   
UBER_BCH = FER_BCH/K;
%loglog(SIGMA_BCH,FER_BCH,'r-o');
loglog(RBER_BCH,FER_BCH,'r-o');
hold on;grid on;
loglog(RBER_BCH,FER_NONE,'b--*');
set(gca,'XDir','reverse');
xlabel('sendBER');
ylabel('receiveFER');
legend('BCH(511,484)','NONE code');