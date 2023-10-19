data {
  int<lower = 0> N;
  vector[N] t;
  int<lower=0> cases[N];
}

parameters {
  real<lower=0> intercept;
  real b;
  real<lower=0> alpha;
  real<lower=100000,upper=80000000> cc;
}

transformed parameters {
  real a = cc / intercept - 1;
  vector<lower=0>[N] growth = cc ./ (1 + a * exp(-b * t));
  }

model {
  intercept ~ exponential(0.01);
  b ~ normal(0.3, 0.1);
  cc ~ uniform(100000, 80000000);
  alpha ~ gamma(6, 1);
  cases ~ neg_binomial_2(growth, alpha);
}

generated quantities {
  int<lower=0> case_sims[N] = neg_binomial_2_rng(growth, alpha);
  }
