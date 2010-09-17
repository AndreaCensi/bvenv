
bvenv
=====

This is a meta-package that manages the installation of all the software
necessary for the bootstrapping simulations contained in the paper that can be found at the page http://purl.org/censi/2010/boot. ("bvenv" stands for "Bootstrapping Vehicles Environment") 

It utilizes the following packages. Each has its own repository.


* bvexp201007_ contains the code that manages the simulations.  

* pybv_ is a python simulator of the various sensors and random environments.

* raytracer_ is a C++ raytracer used by pybv to simulate a range-finder.

* snp_geometry_ contains some utils to manipulate poses.

* reprep_ is a library used for creating reports in html (for inspection) and their latex versions (for publishing).

* compmake_ is a parallel "make" for batch python processes -- the weeks I used to write this were well repaid by the time it made me save for the bootstrapping simulations.

* json-c_ is a port to ansi-c, with some addons, of a popular C JSON library.

* jsonstream_ contains Python functions to read a stream of JSON objects.

* patience_ is the script  that automates downloading and installing of the other packages.


.. _bvenv: http://andreacensi.github.com/bvenv/
.. _bvexp201007: http://andreacensi.github.com/bvexp201007/
.. _pybv: http://andreacensi.github.com/pybv/
.. _raytracer: https://github.com/AndreaCensi/raytracer
.. _snp_geometry: https://github.com/AndreaCensi/snp_geometry
.. _compmake: http://compmake.org
.. _json-c: https://github.com/AndreaCensi/json-c
.. _reprep: http://andreacensi.github.com/reprep/
.. _github: http://www.github.com
.. _patience: https://github.com/AndreaCensi/patience
.. _jsonstream: https://github.com/AndreaCensi/jsonstream


I found out that having very small libraries/repositories and aggregating meta-packages works very well for me for code reuse.


Download and install
--------------------

For history, branches, etc., see the github page http://github.com/AndreaCensi/bvenv

.. raw:: html
   :file: download.html

.. _me: http://purl.org/censi/


Usage
------

1. Read the documentation concerning the required dependencies.
   It has been tested in OS X and Ubuntu/Fedora.

   :ref:`osnotes`

2. Run the script ``bvenv_boot.sh``: ::

   $  ./bvenv_boot.sh

   This creates a Python virtual environment in the subdirectory
   ``deploy/``. It downloads and installs in ``deploy/``
   all the packages mentioned above.

   Moreover, it creates a file called ``environment.sh`` which
   contains all the environment variables that you need to run the software
   in ``deploy/``.

3. Use the environment variables: ::
   
   $ source environment.sh
   
At this point everything is installed. See the instructions 
in the package bvexp2010_ to actually run the simulations.
 

.. _bvexp2010: http://andreacensi.github.com/bvexp2010



