<?php

/**
 * Local XAMPP database configuration.
 */

$databases['default']['default'] = [
  'driver' => 'mysql',
  'database' => 'drupal_local',
  'username' => 'root',
  'password' => '123456789',
  'host' => '127.0.0.1',
  'port' => '3306',
  'prefix' => '',
];

$settings['config_sync_directory'] = dirname(DRUPAL_ROOT) . '/config/sync';
