Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* (TODO) YOUR NAME HERE
* Tested on: (TODO) Windows 22, i7-2222 @ 2.22GHz 22GB, GTX 222 222MB (Moore 2222 Lab)

### (TODO: Your README)

*DO NOT* leave the README to the last minute! It is a crucial part of the
project, and we will not be able to grade you without a good README.

### CMakeLists Modification

Change cmake minimum required version from 2.8.12 to cmake_minimum_required(VERSION 4.1) for both ./CMakeLists.txt and ./externel/GLFW/CMakeLists.txt

In ./externel/GLFW/CMakeLists.txt, change cmake_policy(SET CMP0042 OLD) to cmake_policy(SET CMP0042 NEW)