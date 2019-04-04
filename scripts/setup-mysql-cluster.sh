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
            gcloud auth activate-service-account --key-file luxx-192320-7111cd714860.json
            gcloud components install core gsutil kubectl
            gcloud components update --quiet
            gcloud config set project luxx-192320
            gcloud config set compute/zone us-east4-a
            export PROJECT_ID="$(gcloud config get-value project -q)"

			if [ -d "../env/$ENVIRONMENT" ];  then
				echo "Copying $ENVIRONMENT environment files..."

				cp -v ../env/$ENVIRONMENT/*.cnf ./cnf/

				echo "Build & Tag $ENVIRONMENT docker image..."

	            docker -v build -t us.gcr.io/luxx-192320/luxx-mysql-cluster-$ENVIRONMENT:$VERSION .
				docker -v push us.gcr.io/luxx-192320/luxx-mysql-cluster-$ENVIRONMENT

				echo "Cleanup"

				cp -v ../template/cnf/*.cnf ./cnf/

				echo "Done"
			fi
		;;

	    package)
            docker run dotcms:"$VERSION"
        ;;

        deploy)
            docker run -d --net=luxx-mysql-cluster-local --name=management1 --ip=10.100.0.2 us.gcr.io/luxx-192320/luxx-mysql-cluster-local:7.6 ndb_mgmd
		    docker run -d --net=luxx-mysql-cluster-local --name=ndb1 --ip=10.100.0.3 us.gcr.io/luxx-192320/luxx-mysql-cluster-local:7.6 ndbd
		    docker run -d --net=luxx-mysql-cluster-local --name=ndb2 --ip=10.100.0.4 us.gcr.io/luxx-192320/luxx-mysql-cluster-local:7.6 ndbd
		    docker run -d --net=luxx-mysql-cluster-local --name=mysql1 --ip=10.100.0.10 -e MYSQL_RANDOM_ROOT_PASSWORD=true us.gcr.io/luxx-192320/luxx-mysql-cluster-local:7.6 mysqld
		    docker run -d --net=luxx-mysql-cluster-local --name=mysql2 --ip=10.100.0.11 -e MYSQL_RANDOM_ROOT_PASSWORD=true us.gcr.io/luxx-192320/luxx-mysql-cluster-local:7.6 mysqld
		    docker run -it --net=luxx-mysql-cluster-local us.gcr.io/luxx-192320/luxx-mysql-cluster-local:7.6 ndb_mgm
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