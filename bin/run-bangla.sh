#!/bin/sh
set -xe
if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

if [ ! -f "data/bangla/bangla.csv" ]; then
    echo "Preprocessing bangla voice collect data, saving in ./data/bangla."
	python3 -u bin/import_bangla.py ./data/bangla
fi;


checkpoint_dir=./models/bangla/

python3 -u DeepSpeech.py \
  --train_files data/bangla/bangla.csv \
  --dev_files data/bangla/bangla.csv \
  --test_files data/bangla/bangla.csv \
  --train_batch_size 12 \
  --dev_batch_size 12 \
  --test_batch_size 12 \
  --n_hidden 494 \
  --epoch 10 \
  --checkpoint_dir "$checkpoint_dir" \
  "$@"
