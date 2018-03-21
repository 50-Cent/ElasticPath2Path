# ElasticPath2Path

ElasticPath2Path (synonymously ElasticP2P) is a substantial improvement over Path2Path, a state-of-the-art by Basu et al. (ISBI).
This tool takes two .swc files corresponding to two different neurons as input, and outputs a scalar number as the distance. 
The additional feature that is added to Path2Path is the continuous elastic morphing between the paths from one neuron to that of another. 
This aids in the visualization of the morphing between two neurons, which might answer the underlyig physiological process. 

Usage:
1. Run the mainUser.m . 
2. Give path of the "Directory" where the input files are located. The input files are arranged in the following way (sample example) :
                          
                
Directory -----|------- motor     ----- CNG version --- file2.swc
               |------- Ganglion  ----- CNG version --- file3.swc
               
3. The program will read all the .swc files in that directory in a serial order, and asks the user to input the serial numbers of the two neurons to compare.

4. The program also asks the number of samples that each path must have after resampling. (ex. 170)

5. While running, it shows the distance, the number of paths of the two neurons, and an animation of morphing. 

6. The features of the animation can be changed from visualMorphingNeuron.m. One can chane the view angle, frame rate, colors of the paths and others.  

7. The visualMorphingNeuron.m checks and creates a directory, named 'videoRepo' in the working path, and save the .avi files into that directory. 
               
   
