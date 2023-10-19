data {
  int<lower=0> N;
  vector[N] t;
}

generated quantities {
  real a = normal_rng(0, 100);
  real b = normal_rng(0.3, 0.3);
  real sigma = fabs(normal_rng(0, 100));
  array[N] real cases_sim = normal_rng(a * pow(1 + b, t), sigma);
}

