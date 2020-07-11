# Extend from the official Elixir image
FROM bitwalker/alpine-elixir-phoenix:latest

ENV SECRET_KEY_BASE=
ENV MIX_ENV=prod
ENV PORT=4000

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force

RUN SECRET=$(mix phx.gen.secret)\
    $SECRET_KEY_BASE=SECRET
RUN echo ${SECRET_KEY_BASE}
RUN mix deps.get
RUN mix compile
RUN npm i --prefix ./assets
RUN npm run deploy --prefix ./assets
RUN mix phx.digest

EXPOSE 4000
CMD ["mix", "phx.server"]