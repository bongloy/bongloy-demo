# Bongloy Demo

This app demonstrates how to use bongloy

## Usage

1. Ensure bongloy-assets is running locally

```shell
cd bongloy-assets
bundle exec foreman start web
```

2. Set the correct host IP address in [bongloy-assets](https://github.com/dwilkie/bongloy-assets#checkoutjs)

3. Set the correct IP address in [script src](https://github.com/dwilkie/bongloy-demo/blob/master/app/views/charges/new.html.haml#L11)

4. Start the server demo server

```shell
bundle exec rails s
```
