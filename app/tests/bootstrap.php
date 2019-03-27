<?php

$rootDir = dirname(__DIR__);

if (!file_exists($rootDir.'/vendor/autoload.php')) {
    throw new RuntimeException('Install dependencies to run test suite.');
}
