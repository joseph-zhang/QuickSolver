# 2018/10/5
# this file contains some basic methods for development environment
# system : ubuntu 16.04
# CPU : Intel Core i7-7700HQ x 8
# GPU : GTX1060 -> Driver Version: 384.98
# env : python2, python3, clang/clang++, gcc/g++
# construct : GPU driver, Cuda8.0, Cudnn6.0, Opencv3.2, caffe, tensorflow-1.3.0
# python environment can be constructed either 2ed or 3ed, the following configure is 2ed
# note that environment for py-3ed is also very easy, just install pip3 and use it to install py-libs
# fonts:
#     system: sarasa-mono-sc-regular
#     editor: iosevka-cc-slab-extralight
#     CJK for latex: Source Han Serif SC

# GPU Driver installation
# find the proper version for your GPU (my GPU is GTX1060, select the version 384.98)
# note that the disable security boot should be selected
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get install nvidia-384 nvidia-settings
nvidia-smi


# cuda8.0
# the reason for installing this version is considered
# after installation, the following configure should be added in bashrc
sudo gedit ~/.bashrc # open this file
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
source ~/.bahsrc
cat /usr/local/cuda/version.txt # check cuda version

cd /usr/local/cuda-8.0/samples/1_Utilities/deviceQuery
make
sudo ./deviceQuery # test


# cudnn6.0
# this version is good for cuda8.0
# after decompression, a dir named cuda in cudnn package should be seen
cd cuda
sudo cp include/cudnn.h /usr/local/cuda/include/
sudo cp lib64/lib* /usr/local/cuda/lib64/

cd /usr/local/cuda/lib64/
sudo rm -rf libcudnn.so libcudnn.so.6    # delete original dynamic file
sudo ln -s libcudnn.so.6.0.21 libcudnn.so.6  # soft link
sudo ln -s libcudnn.so.6 libcudnn.so      # soft link
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2 # check cudnn version


# opencv3.2
# this is a key process, many wierd problems can be seen
# first download the package from opencv.org, decompress it at no matter where you want
cd opencv-3.2.0 # up to your own path
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j8 # parallel compiled, up to your own cpu condition
sudo make install # install opencv
pkg-config --modversion opencv # check opencv version


# python relations
# this step is very important for next installations
sudo apt-get install -y python-numpy python-scipy python-matplotlib python-sklearn python-skimage python-h5py python-protobuf
sudo apt-get install -y python-leveldb python-networkx python-nose python-pandas python-gflags cython ipython

# some other important relations for caffe installations
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev
sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler protobuf-c-compiler protobuf-compiler
sudo apt-get install -y libatlas-base-dev

# caffe
# execute at where you want to install 
git clone https://github.com/BVLC/caffe.git
sudo cp Makefile.config.example Makefile.config
sudo gedit Makefile.config # open this file to fix some code
# set OPENCV_VERSION := 3
# set USE_CUDNN := 1
# fix INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial
# fix LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/hdf5/serial
sudo gedit makefile
# fix NVCCFLAGS += -D_FORCE_INLINES -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)
# fix LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial
# then move to caffe path, and excute following command
make all -j8
make test -j8
make runtest -j8
make pycaffe -j8 # compile pycaffe

cd data/mnist 
sudo sh ./get_mnist.sh # down load mnist data
cd ~/caffe-master # move to your own caffe path
sudo sh ./examples/mnist/create_mnist.sh # data recompose
sudo sh ./examples/mnist/train_lenet.sh # train the mnist dataset 

# tensorflow-1.3.0
# note that the tensorflow version >= 1.4 need Cuda9.0
sudo pip install tensorflow-gpu==1.3.0 # for python2.7, GPU support

# latex
# the latex environment on my system(ubuntu16.04) is Emacs + AucTeX + TeXLive
sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt-get install emacs25 # if you don't have emacs
sudo apt-get install texlive-full # consider your hard disk space
# then get auctex on  http://www.gnu.org/software/auctex/
# decompress it and move to your path, execute
./configure --with-emacs
make
make install # done!
# the configure of ./emacs file is up to you;
# To add latex support for spacemacs, check this page 
# https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/latex
# just add latex in dotspacemacs-configuration-layers.
# To enable auto-fill, add the following line in dotspacemacs-configuration-layers:
# (latex :variables latex-enable-auto-fill t)

# opengl3
sudo apt-get install build-essential freeglut3 freeglut3-dev binutils-gold

# install opencv interface for python3
pip3 install opencv_python

# optional: GHC for haskeller
# the version of ghc and cabal is up to you
sudo add-apt-repository ppa:hvr/ghc
sudo apt-get install ghc-8.2.2
sudo apt-get install cabal-install-1.24
# add something to ~/.bashrc
# alias ec="emacsclient25 -nw"
# alias en="emacs25 -nw"
# alias ecw="emacsclient25"
# export PATH=~/.cabal/bin:/opt/ghc/bin:/opt/cabal/bin:$PATH
source ~/.bashrc

# optional: Ruby env for rubyist
sudo apt-get install ruby-full
gem install rails
# optional: jekyll
gem install jekyll
gem install bundler # If you don't have bundler installed
bundle install
gem install kramdown

# optional: Racket for schemer 
sudo add-apt-repository ppa:plt/racket
sudo apt-get update
sudo apt-get install racket

# optional: Rust for Rustacean
curl https://sh.rustup.rs -sSf | sh
# then check the version with
rustc --version
# if failed, add the path to your bashrc and do
source ~/.bashrc
# note that the addition should be
export PATH=~/.cargo/bin:$PATH 
# check it again, you can also find that cargo is installed.

# optional: nvm for JSer
# check nvm homepage and install it. It is useful for node version management.
# after nvm is installed, use following code to install latest release of node
nvm install node
# then use
nvm use node
# to check the node version. the npm should also be installed correctly.
# to check the installed instances of nvm, just use
nvm ls

# optional: OPAM for ocaml or coq user
# note that coq is implemented by ocaml, hence ocaml is necessary,
# the recommended way to install ocaml and coq is OPAM, which is the package manager of ocaml.
# to install OPAM: http://opam.ocaml.org/doc/Install.html#Binary-distribution
add-apt-repository ppa:avsm/ppa
apt-get update
apt-get install ocaml ocaml-native-compilers camlp4-extra opam
# and then install coq and some related packages: https://coq.inria.fr/opam/www/using.html
# note that the following version 8.8.1 is just an example
export OPAMROOT=~/opam-coq.8.8.1 # installation directory
opam init -n --comp=4.02.3 -j 2 # 2 is the number of CPU cores(can be changed)
opam repo add coq-released http://coq.inria.fr/opam/released
opam install coq.8.8.1 && opam pin add coq 8.8.1
# to run coq, don't forget to add its path in bashrc
# that is, add following two lines:
export OPAMROOT=~/opam-coq.8.8.1
eval `opam config env`
# then use this to check coq version
coqc -v
# To add spacemacs support of coq, we need coq-mode
# but it is not so easy to configure it.
# what we need: coq(of course), PG(i.e. Proof General: https://proofgeneral.github.io/),
# coq-layer(http://develop.spacemacs.org/layers/+lang/coq/README.html#laying-out-windows).
# here is a tutorial: http://ignatirabo.github.io/misc/2017/11/25/coq-in-spacemacs/
# first clone PG to emacs.d and make it
git clone https://github.com/ProofGeneral/PG ~/.emacs.d/lisp/PG
cd ~/.emacs.d/lisp/PG
make
# then clone coq-layer to our configuration layer folder and rename it to 'coq
cd ~/.spacemacs.d/layers
git clone https://github.com/olivierverdier/spacemacs-coq.git
mv spacemacs-coq coq
# and then modify the config.el in coq layer
# replace "yourname" according to your own system config
(defvar proof-general-path "/home/yourname/.emacs.d/lisp/PG/generic/proof-site"
  "The path to proof general")
# after that, restart emacs and wait for a while, it will install company-coq for us.

# optional: JDK for javaer
# first download the Java SE Development Kit from
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# then decompress it (take jdk-8u181 as example)
tar -zxvf jdk-8u181-linux-x64.tar.gz
# move it to /usr/local/
sudo mv jdk1.8.0_181/ /usr/local/
# create soft link
sudo ln -s /usr/local/jdk1.8.0_181/ /usr/jdk
# then modify ~/.bashrc as what I showed.
# activate it:
source ~/.bashrc
# check if it work
java -version

# optional: sbt for scala user
# before installation, check following two pages:
# https://www.scala-lang.org/download/
# https://docs.scala-lang.org/getting-started-sbt-track/getting-started-with-scala-and-sbt-on-the-command-line.html
# The most important thing to "install" scala:
# Compared to other programming languages, installing Scala is a bit unusual.
# Scala is unusual because it is usually installed for each of your Scala projects 
# rather than being installed system-wide!!
# who can do this? ==> sbt, the scala build tool.
# Hence, all we need is just sbt, it will automatically download proper scala version according to specific project,
# because a single local scala version is usually not enough.
# (note that spt needs JDK)
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt
# Now sbt is installed.
# However, it's also possible to "install" Scala.
# This means install a specific scala version and use it from the command line.
# check scala official website, select a release and download it.
# then decompress it and move it to /opt/scala,
# just export its path in bashrc, then do activation.
# check local scala version
scala -version
