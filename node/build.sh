
BUILD_DIR=$(cd $(dirname $0) && pwd)
echo "BUILD_DIR $BUILD_DIR"
RELEASE_VERSION=v3.31.2-custom
echo "Version is ${RELEASE_VERSION}"
IMAGE_NAME='calico/node'
IMAGE_WITH_VERSION=$IMAGE_NAME:$RELEASE_VERSION

make clean

MAKE_RESULT="$(cd $BUILD_DIR && make image)"


if [ ! -z "$REGISTRY" ]; then
    version_tag=$REGISTRY/$IMAGE_WITH_VERSION
    docker tag $IMAGE_NAME:latest $version_tag

    if [ "$PUSH_TO_REGISTRY" = true ] ; then
        docker push $version_tag
    fi
fi
