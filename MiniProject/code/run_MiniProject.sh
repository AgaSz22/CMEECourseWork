###Agnes Szwarczynska
### 4 Dec 2022
### Main script that runs every other script needed for the MiniProject
#!/bin/bash 

Rscript MiniProject_main_script.R

chmod u+x texcount.pl
texcount -1 -sum MiniProject_Latex.tex > MiniProject_Latex-words.sum ###needed for the correct wordcount in Latex
bash CompileLaTex.sh MiniProject_Latex