#!/bin/bash

ssh -L localhost:5080:localhost:5080 $1
