#Build Instructions
mix deps.get
npm install
cd assets
npm install
cd ..
npm run deploy --prefix ./assets
mix phx.digest
echo 'Y'| MIX_ENV=prod mix release 
