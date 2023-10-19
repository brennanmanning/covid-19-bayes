data {
  int<lower=0> N;
  vector[N] t;
}

generated quantities {
  real intercept = exponential_rng(0.01);
  real b = normal_rng(0.3, 0.1);
  real cc = uniform_rng(100000, 80000000);
  real a = cc / intercept - 1;
  real alpha = gamma_rng(6, 1);
  vector[N] growth = cc ./ (1 + a * exp(-b * t));
  int<lower=0> case_sims[N] = neg_binomial_2_rng(growth, alpha);
}

