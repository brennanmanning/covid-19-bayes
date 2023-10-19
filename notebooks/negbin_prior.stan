data {
  int<lower=0> N;
  vector[N] t;
}

generated quantities {
  real a = exponential_rng(0.01);
  real b = normal_rng(0.3, 0.1);
  real alpha = gamma_rng(6, 1);
  array[N] real cases_sim = neg_binomial_2_rng(a * (1 + b)^ t, alpha);
}

