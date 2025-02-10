# Build and push docker images
docker compose build #--push

# Deploy main application stack
echo "Deploying monitoring stack..."
docker stack deploy --with-registry-auth -c docker-compose.yml monitoring 
