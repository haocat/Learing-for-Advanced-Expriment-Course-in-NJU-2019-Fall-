ORDER = 15;
N = 18529 ;  % code length
K = 16384 ;  % information bits
M = N - K ; % check bits

genpoly = bchgenpoly(2^ORDER-1,2^ORDER-1-M);
max_err = bchnumerr(2^ORDER-1,2^ORDER-1-M);


SIGMA_BCH = [0.405, 0.4025, 0.4, 0.3975, 0.395, 0.3925, 0.39, 0.3875, 0.385, 0.38];
RBER_BCH = 1-normcdf(0, -1, SIGMA_BCH);
FER_BCH = 1 - binocdf(max_err,N,RBER_BCH);   
UBER_BCH = FER_BCH/K;
loglog(RBER_BCH,FER_BCH,'r-o');
set(gca,'XDir','reverse');
xlabel('RBER');
ylabel('FER');
