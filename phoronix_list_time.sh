#!bin/bash

#List the property "Estimate Run-Time" for phoronix-test-suite tests from command line.

#names= $(
phoronix-test-suite list-available-tests | grep Processor | awk '{ print $1; }' > ptsnames #| tr '\n' '\0')

for elem in `cat ptsnames`; do
    echo
    echo -n $elem ": "
    echo -n $elem | tr '\n' '\0' | xargs -0 -n1 phoronix-test-suite info | grep Run-Time | tr '\n' '\\' #| xargs += ": "
    #echo -n "; "
done

