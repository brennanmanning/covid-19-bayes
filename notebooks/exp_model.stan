data {
    int<lower=0> N;
    vector[N] t;
    vector[N] cases;
}

parameters {
    real a;
    real b;
    real<lower=0> sigma;
}

model {
    a ~ normal(0, 1);
    b ~ normal(0.3, 0.5);
    sigma ~ normal(0, 1);
    cases ~ normal(a * pow(1 + b, t), sigma);
}

