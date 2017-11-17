#!/bin/sh
set -xe
if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

if [ ! -f "data/testbangla/bangla.csv" ]; then
    echo "Preprocessing bangla voice collect data, saving in ./data/testbangla."
    python3 -u bin/import_bangla.py ./data/bangla
	python3 -u bin/import_bangla.py ./data/testbangla
fi;


checkpoint_dir=./models/bangla/

python3 -u DeepSpeech.py \
  --train_files data/bangla/bangla.csv \
  --dev_files data/bangla/bangla.csv \
  --test_files data/testbangla/bangla.csv \
  --train_batch_size 10 \
  --dev_batch_size 10 \
  --test_batch_size 1 \
  --epoch 20 \
  --learning_rate 0.0001 \
  --default_stddev 0.046875 \
  --checkpoint_dir "$checkpoint_dir" \
  "$@"
