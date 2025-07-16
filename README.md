# RECURSIVE TEMPLATE FOR C

## <sup>layer 1</sup> ABOUT
This is a simple recursive templace for C language. The idea is to have the project structured recursively, so it can be better organized. The template uses Makefile to structure, compile and edit the project. I will be putting the essencial commands here, but you can check and edit at your will in [Makefile](https://github.com/iwametal/c-project-recursive-template/Makefile). This project uses Linux as its based system, so it might have problems running on Windows or Mac. However it should be possible by changing the Makefile commands and debug configurations or using a container machine (e.g. WSL).


[comment]: <> (<p align="center">last update: Month Day<sup>st</sup>, Year</p>)

## <sup>layer 2</sup> INSTALLATION AND CONFIGURATION

First, just clone the template into your machine.
```
$ git clone https://github.com/iwametal/c-project-recursive-template.git
```

Once its cloned, you can change the folder name to your project name and init the project
```
$ cd c-project-recursive-template
$ bash init.sh
```

And you're ready to start the coding. Init.sh script will already change the directory name for your new project name. You might need to `cd ..` and `cd MyProjectNewName` in your terminal and reopen the project in your IDE / Editor (if it was already opened).

## <sup>layer 3</sup> USAGE
The project uses Makefile for all basic commands, including compiling, tests and creating new folders for your project. It is important to use the Makefile to create new sub-directories, since it already automatically puts the files needed for compilation.

Use `Make help` for a brief menu of all available commands.

## <sup>layer 4</sup> DEPENDENCIES
The dependencies used in code might vary depending on you project. The way this template is made, two dependencies are used: valgrind for VIM debug and cmocka for unit tests. Although I do have a dependencies file, it doesn't automatically install them, its simply used for documentation. You can substitute it for your own requirements file.