
.. _osnotes: 

Operating Systems notes
=======================

Notes for Ubuntu 10.04
------------------------------------------

These are sufficient instructions to get the software running on Ubuntu 10.04. 
As of Apr. 2010, it is the long term support (LTS) version of Ubuntu.
I plan to update these instructions for every future LTS version.

Please let me know if you encounter difficulties!


Upgrade the system: ::

    $ sudo apt-get update
    $ sudo apt-get upgrade

Install required software: ::

    $ sudo apt-get install subversion git-core cmake libcairo2-dev ncurses-dev g++
    $ sudo apt-get install python-dev python-setuptools python-numpy 
    $ sudo apt-get install python-nose python-matplotlib  python-virtualenv 


.. These are for real experiments 

	For building the paper: ::

	    $ sudo apt-get install  lyx lyx-common

	For running real robot experiments:

	    sudo apt-get install spread python-spread python-pygame

	For processing the data:
	    opencv --- 2.1; not the one on the repo
    
	For creating the video:

	    pymedia --- this will need to be installed manually



Notes for Ubuntu 8.04
----------------------

Installing required packages: ::

    $ sudo apt-get install subversion git-core cmake libcairo2-dev ncurses-dev g++
    $ sudo apt-get install python-dev python-setuptools python-numpy
    $ sudo apt-get install python-nose python-matplotlib  
    $ sudo easy_install virtualenv

(Note: python-virtualenv is not available in this version of ubuntu)

Notes for Fedora 13
-------------------

Installing yum packages: ::

    $ yum install subversion git cmake
    $ yum install gsl gsl-devel gsl-static
    $ yum install cairo-devel pycairo pycairo-devel
    
     