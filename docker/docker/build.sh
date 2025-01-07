VER=1.4
docker build . -t cr.yandex/crpacdetsu8hcv118m0j/iam-idp-test:${VER?}
docker push cr.yandex/crpacdetsu8hcv118m0j/iam-idp-test:${VER?}

#docker run -p 8080:8080 iam-idp-test
