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
  --train_batch_size 10 \
  --dev_batch_size 10 \
  --test_batch_size 10 \
  --learning_rate 0.0001 \
  --epoch 5 \
  --n_hidden 400 \
  --display_step 5 \
  --validation_step 5 \
  --dropout_rate 0.30 \
  --default_stddev 0.046875 \
  --checkpoint_dir "$checkpoint_dir" \
  "$@"
