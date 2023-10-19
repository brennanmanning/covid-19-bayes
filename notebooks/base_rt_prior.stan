data {
  int<lower=0> N;
}

generated quantities {
  real alpha = gamma_rng(36, 6);
  vector[N] logrt;
  logrt[1] = normal_rng(0, 0.035);
  for (n in 2:N){
    logrt[n] = normal_rng(logrt[n-1], 0.035);
  }
  vector[N] rt = exp(logrt);
  array[N] int cases_sim;
  cases_sim[1] = 1;
  for (n in 2:N) {
    cases_sim[n] = neg_binomial_2_rng(rt[n] * cases_sim[n-1] + 0.01, alpha);
  }
}

