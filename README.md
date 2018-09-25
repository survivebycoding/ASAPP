# asapp
In the folder you will find the following files:
1. ID_extraction.m
2. finalrdm.m
3. URLdownload.m
4. kegg_compound_list.mat

The ID_extraction is the main file that needs to be executed.

The kegg_compound_list.mat file is the database of different compounds available in KEGG database and their respective identifiers in the format C*****.

On executing file "ID_extraction.m", an input dialog box pops up asking for different file names and locations needed to execute ASAPP.

For field "Enter compound database path and file name:" give the path of the file "kegg_compond_list". This file should be kept in the default Matlab folder created when Matlab was installed.

For field "Enter the input file name" give the path of the file with the list of compounds for which the pathway is to be predicted.

For field "Enter the file name in which the output is displayed" give the path of the file into which the predicted pathway is to be written.

For fields asking for random files, give the path of 3 random file names along with their locations.

The folder "Sample" has got a few sample files which contains random combination of compounds. One can test the program with those samples. One can also create a text file consisting of a list of compound names of their choice.

At the end of the file, there are two 'run' commands. You need to give the name and location of the other two files, URLdownload and finalrdm.

Check that you have a stable internet connection.

The result can be viewed in the Matlab command window as well as in the result file
