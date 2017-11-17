#!/usr/bin/env python
from __future__ import absolute_import, division, print_function

# Make sure we can import stuff from util/
# This script needs to be run from the root of the DeepSpeech repository
import sys
import os
sys.path.insert(1, os.path.join(sys.path[0], '..'))

import pandas
import fnmatch

def _preprocess_data(data_dir):
	transcript = []
	with open(data_dir+"/bangla.txt") as fin:
		transcript = fin.read().strip('\r').split('\n')
	files = []
	for root, dirnames, filenames in os.walk(data_dir):
		for filename in fnmatch.filter(filenames, "*.wav"):
			wavfile = os.path.join(data_dir,filename)
			index = int(filename.split('_')[0])
			files.append([os.path.abspath(wavfile),os.path.getsize(wavfile), transcript[index]])
	
	df = pandas.DataFrame(data=files, columns=["wav_filename", "wav_filesize", "transcript"])
	df.to_csv(os.path.join(data_dir, "bangla.csv"), index=False)

if __name__ == "__main__":
    _preprocess_data(sys.argv[1])
