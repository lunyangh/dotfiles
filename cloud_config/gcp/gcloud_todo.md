# TODO 

# replicate python environment 
* transfer to another virtual machine 
    * image 
    * docker 

* install packages -> image 

* written python library -> github repos 

* scalable 
* spot VM is very cheap 0.2 of on-demand VM (persistent VM we use as server)
    * keep spot VM same environment as dev server 
        * install packages -> image 
        * access written python library 
            * naive method: (develop sever -> github -> spot VM)
            * faster method: 
                * shared disk 
                * develop server -> google cloud storage -> spot VM
    * how to manage many submitted tasks 
        * 200 tasks, -> 10 spot VM  
            * how to get log 
            * how to assign task -> VM 
            * software: slurm + gcp 

## check different approaches to solve parallel computing. 

Some useful packages mentioned online
1. hydra from meta for configuration
2. weight & bias for experiment tracking.


## various AI tools 

### claude code
* claude code
    * if you have a codebase with many files 
    * 200-1000 code editing across mutliple files. 

    * vide coding: ai write codebase from scratch. 

* use pattern: 
    * analyze -> plan -> execute 
    * plan make to do list
    * plan -> code ok level -> execute -> modify 10-20%

* implication: 
    * maybe let AI to write from scratch. (prompt)
    * speedup personal project save much time. 

### perplexity LLM
* search engine -> obtan real-time accurate information source. 

### notebookLM (google)
* collect information source 
* active ask chat -> question driven 
* let chat summarize what you just asked. -> markdown file save locally. 


