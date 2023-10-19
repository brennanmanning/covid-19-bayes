data {
  int<lower=0> N;
  array[N] int<lower=0> cases;
}

parameters {
  vector[N] logrt;
  real<lower=0> alpha;
}

transformed parameters {
  vector[N] rt = exp(logrt);
}

model {
  alpha ~ gamma(36, 6);
  logrt[1] ~ normal(0, 0.035);
  for (n in 2:N) {
    logrt[n] ~ normal(logrt[n-1], 0.035);  
  }
  for (n in 2:N) {
    cases[n] ~ neg_binomial_2(rt[n] * cases[n-1] + 0.01, alpha);
  }
}

generated quantities {
  array[N] int<lower=0> cases_sim;
  int large = 10000000;
  cases_sim[1] = cases[1];
  for (n in 2:N) {
    cases_sim[n] = neg_binomial_2_rng(rt[n] * cases_sim[n-1] + 0.01, alpha);
    cases_sim[n] = cases_sim[n] > large ? large : cases_sim[n];
  }
}

