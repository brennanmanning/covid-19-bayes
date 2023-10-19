data {
  int<lower=0> N;
  vector[N] t;
  int<lower=0> cases[N];
}

parameters {
  real<lower=0> a;
  real b;
  real<lower=0> alpha;
}

transformed parameters {
  vector<lower=0>[N] mu = a * pow(1 + b, t);
}

model {
  a ~ exponential(0.01);
  b ~ normal(0.3, 0.1);
  alpha ~ gamma(6, 1);
  cases ~ neg_binomial_2(mu, alpha);
}

generated quantities {
  int<lower=0> case_sims[N] = neg_binomial_2_rng(mu, alpha);
}

