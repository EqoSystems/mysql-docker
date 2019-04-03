#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

VERSION="$1"
STEP="$2"
ENVIRONMENT="$3"

if [ -d "./$VERSION" ]; then
    cd "./$VERSION"
	case "$STEP" in
	    base-image)
	        docker pull mysql/mysql-cluster:$VERSION
	        docker tag mysql/mysql-cluster:$VERSION us.gcr.io/luxx-192320/mysql-cluster:$VERSION
	        docker push us.gcr.io/luxx-192320/mysql-cluster:$VERSION
	    ;;

		build)

			if [ -d "../env/$ENVIRONMENT" ];  then
				echo "Copying $ENVIRONMENT environment files..."

				cp -v ../env/$ENVIRONMENT/*.cnf ./cnf/

				echo "Build & Tag $ENVIRONMENT docker image..."

	            docker -v build -t us.gcr.io/luxx-192320/luxx-mysql-cluster-$ENVIRONMENT:$VERSION .
				docker -v push us.gcr.io/luxx-192320/luxx-mysql-cluster-$ENVIRONMENT

				echo "Cleanup"

				cp -v ../template/cnf/*.cnf ./cnf/

				echo "Done"
			else
				cp ../env/prod/*.cnf ./cnf/
	            docker build -t us.gcr.io/luxx-192320/luxx-mysql-cluster-prod:$VERSION .
				docker push us.gcr.io/luxx-192320/luxx-mysql-cluster-prod
				cp ../template/cnf/*.cnf ./cnf/
				echo "Done"
			fi
		;;

	    package)
            docker run dotcms:"$VERSION"
        ;;

        deploy)
            docker run dotcms:"$VERSION"
        ;;

        run)

        ;;


	    *)
	        echo "Unhandled step"
	    ;;
	esac
else
    echo "Version: $VERSION not handled."
fi