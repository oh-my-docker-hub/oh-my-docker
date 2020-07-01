PROJECT_NAME="$1";
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Usage:\nsh $0 PROJECT_NAME"
    exit;
fi
# git clone https://github.com/oh-my-docker-hub/oh-my-docker;
# cd oh-my-docker;
mkdir -p build/$PROJECT_NAME/conf
touch build/$PROJECT_NAME/README.$PROJECT_NAME.md;
touch build/$PROJECT_NAME/Dockerfile;
touch build/$PROJECT_NAME/docker-compose.yaml

echo "PROJECT: $PROJECT_NAME"
echo "PATH: build/$PROJECT_NAME"
echo "finish!"