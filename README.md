# Telic-Wroclaw
An experiment programmed in Matlab R2015a.

This experiment also uses Psychtoolbox version 3.0.12. For more information, see [the github page](https://github.com/Psychtoolbox-3/Psychtoolbox-3).

This experiment contains 20 trials, with two animations per trial.


##Telic Wroclaw Prime
A variation of the Telic Wroclaw experiment that randomizes correlation, such that correlated animations may be compared with anticorrelated animations. There are equal numbers of correlated and anticorrelated animations (each appears 20 times).

#Design Changes
This experiment is a revision of previous Telic code, making it clearer and easier to understand. Some of the major changes are as follows:

* Changed the star image, and added a heart

* Created a different timing setu of anticorrelated values

* Separated the loop animation into a distinct function, discrete from the main function

* Polar loops from previous iterations of Telic have been replaced with multiple ellipses. One ellipse corresponds to one petal of a polar loop. To this end, the point generating and break generating functions have been changed.

* The randomized breaks are generated with a different method, and the minimum number of frames between breaks was reduced from 20 to 10 to accomodate having shorter loop times

* The training functions have been condensed into a single function that draws a different sentence depending on the phase of the experiment

* The structure of training is changed. Previously, the experiment would progress through a set of 3 training animations for one, two, and three loops. For this experiment, there are 6 training animations, where there are 2 each of 1, 2, and 3 loops. Half of them are correlated, and the other half are anticorrelated. Half use the star image, and half use the heart image.

* Data is saved to a different location
