<?php

function say($message) {
  echo $message . PHP_EOL;
}

say('output_buffering = ' . ini_get('output_buffering'));
say('post_max_size = ' . ini_get('post_max_size'));
say('upload_max_filesize = ' . ini_get('upload_max_filesize'));
say('memory_limit = ' . ini_get('memory_limit'));
say('expose_php = ' . ini_get('expose_php'));
