#Build Instructions
mix deps.get
npm install
npm run deploy --prefix ./assets
mix phx.digest

