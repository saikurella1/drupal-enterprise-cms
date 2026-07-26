<?php

/**
 * @file
 * Pantheon-specific configuration.
 *
 * This file is included by settings.php only when running on Pantheon.
 * Pantheon automatically provides $databases via its environment —
 * do NOT define $databases here.
 */

/**
 * Trusted host patterns for Pantheon environments.
 * Covers dev/test/live and custom domains.
 */
$settings['trusted_host_patterns'] = [
  // Pantheon default domains (dev, test, live)
  '^.+\.pantheonsite\.io$',
  // Add your custom domain below if you have one, e.g.:
  // '^www\.example\.com$',
  // '^example\.com$',
];

/**
 * Reverse proxy / CDN settings for Pantheon's edge layer.
 */
$settings['reverse_proxy'] = TRUE;
$settings['reverse_proxy_addresses'] = [$_SERVER['REMOTE_ADDR']];

/**
 * Disable CSS/JS aggregation on dev for easier debugging.
 * Remove or invert this for test/live environments.
 */
if (isset($_ENV['PANTHEON_ENVIRONMENT']) && $_ENV['PANTHEON_ENVIRONMENT'] === 'dev') {
  $config['system.performance']['css']['preprocess'] = FALSE;
  $config['system.performance']['js']['preprocess'] = FALSE;
}
