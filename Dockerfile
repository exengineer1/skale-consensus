FROM docker.pkg.github.com/skalenetwork/skale-consensus/consensust_base:latest
WORKDIR /consensust

COPY . /consensust/src/
RUN cd /consensust/src; cp -rf ENGINE_VERSION *.* abstracttcpclient ./abstracttcpclient abstracttcpserver \
   blockfinalize blockproposal catchup cget chains cmake crypto datastructures db exceptions \
   headers json messages monitoring network node pendingqueue pricing protocols \
   test thirdparty threads scripts utils ..
RUN rm -rf /consensust/src

ENV CC gcc-7
ENV CXX g++-7
ENV TARGET all
ENV TRAVIS_BUILD_TYPE Debug

RUN cmake . -Bbuild -DCMAKE_BUILD_TYPE=Debug  -DCOVERAGE=ON -DMICROPROFILE_ENABLED=0
RUN cmake --build build -- -j4