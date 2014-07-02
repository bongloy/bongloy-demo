# Bongloy Demo

This app demonstrates how to use bongloy

## Usage

### With Stripe

Note: It looks like the Remember Me functionality of Stripe Checkout doesn't work when you have it requesting from localhost.

1. Make sure your `STRIPE_PUBLISHABLE_KEY` is set correctly in [.env](https://github.com/dwilkie/bongloy-demo/blob/master/.env)

2. Start the server using foreman

```
bundle exec foreman start web
```

### With Bongloy Checkout (locally)

1. Start the Checkout Server

```
cd bongloy_checkout
bundle exec foreman start web
```

2. Set the correct host IP address in [bongloy-checkout](https://github.com/dwilkie/bongloy-checkout#checkoutjs)

3. Set the correct IP address in [script src](https://github.com/dwilkie/bongloy-demo/blob/master/app/views/charges/new.html.haml#L11)

4. Start the using foreman

```
bundle exec foreman start web
```
