
Step-by-step installation for Ubuntu 10.04
------------------------------------------

These are complete instructions to get the software running on Ubuntu 10.04. 
As of Apr. 2010, it is the long term support (LTS) version of Ubuntu.
I plan to update these instructions for every future LTS version.

Please let me know if you encounter difficulties!


Upgrade the system::

	sudo apt-get update
	sudo apt-get upgrade
	

Install required software:

	sudo apt-get install subversion git-core cmake libcairo2-dev ncurses-dev g++
	sudo apt-get install python-dev python-setuptools python-numpy python-nose python-matplotlib  python-virtualenv

	echo other packages: sudo apt-get install  lyx lyx-common

	
This assumes that you have 



For a comfortable:
	apt-get install vim


Step-by-step installation for Fedora 13
---------------------------------------

	yum install subversion git cmake
	yum install gsl gsl-devel gsl-static
	yum install cairo-devel pycairo pycairo-devel